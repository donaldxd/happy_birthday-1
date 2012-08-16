root = window ? global
root.canvas = $("#canvas")[0]
root.ctx = root.canvas.getContext "2d"
root.canvas.width = root.innerWidth
root.canvas.height = root.innerHeight - 20

stretch =
    min:0.3
    max:10.0

radius =
    min:3
    max:10

nleaf =
    min:3
    max:8

growth =
    min:0.1
    max:2.0


random = (min = 0, max = 1) ->
    Math.random() * (max - min) + min

randInt = (min, max) ->
    Math.floor(Math.random() * (max - min)) + min

randColor = ->
    r = randInt(1, 256)
    g = randInt(1, 256)
    b = randInt(1, 256)
    a = random()
    #a = 0.5
    return "rgba(#{r},#{g},#{b},#{a})"


class Vector
    constructor: (x,y) ->
        @x = x
        @y = y

    mult: (f) ->
        @x *= f
        @y *= f
        return @

    add: (v) ->
        @x += v.x
        @y += v.y
        return @

    rotate: (theta) ->
        #thete degree
        x = @x
        y = @y
        theta *= (Math.PI / 180)
        @x = x * Math.cos(theta) - y * Math.sin(theta)
        @y = x * Math.sin(theta) + y * Math.cos(theta)
        return @

    set: (x, y) ->
        @x = x
        @y = y
        return @

    clone: ->
        return new Vector(@x, @y)


class Leaf
    constructor: (s1, s2, startAngle, angle, growth, flower) ->
        @s1 = s1
        @s2 = s2
        @startAngle = startAngle
        @angle = angle
        @r = 1
        @growth = growth
        @flower = flower
        @ctx = root.ctx
        @finished = false
        @flower.addLeaf @
        @color = randColor()

    draw: ->
        v1 = new Vector(@r,0).rotate(@startAngle)
        v2 = v1.clone().rotate(@angle)
        v3 = v1.clone().mult(@s1)
        v4 = v2.clone().mult(@s2)
        #console.log v1, v2, v3, v4
        #console.log @ctx
        @ctx.save()
        @ctx.translate(@flower.center.x, @flower.center.y)
        @ctx.strokeStyle = @color
        @ctx.beginPath()
        @ctx.moveTo v1.x, v1.y
        @ctx.bezierCurveTo v3.x, v3.y, v4.x, v4.y, v2.x, v2.y
        @ctx.closePath()
        @ctx.stroke()
        @ctx.restore()
        return

    render: ->
        r = @r
        while @r <= @flower.r
            @draw()
            @r += @growth
        @finished = true
        @r = r
        return


class Flower
    constructor: (center, r=10, nLeaf=4) ->
        @center = center
        @r = r
        @nLeaf = nLeaf
        @leaves = []
        @finished = false
        @init()

    addLeaf: (leaf) ->
        @leaves.push leaf

    init: ->
        startAngle = randInt(0, 360)
        angle = 360.0 / @nLeaf
        for i in [0..@nLeaf]
            leaf = new Leaf(random(stretch.min, stretch.max), random(stretch.min, stretch.max), startAngle, angle, random(growth.min,growth.max), @)
            startAngle += angle
        @initialized = true
        return

    render: ->
        for leaf in @leaves
            leaf.render()


showRandomFlowers = (n)->
    #p1 = new Vector(400, 400)
    #f = new Flower(p1, 5, 10)
    #f.render()
    minWidth = 100
    maxWidth = Math.floor(root.canvas.width) - minWidth
    minHeight = 100
    maxHeight = Math.floor(root.canvas.height) - minHeight
    for i in [0..n]
        p = new Vector(randInt(minWidth, maxWidth), randInt(minHeight, maxHeight))
        f = new Flower(p, randInt(radius.min, radius.max), randInt(nleaf.min,nleaf.max))
        f.render()
    return


$("button#btn-start").click ->
    #showRandomFlowers(randInt 0, 100)
    showRandomFlowers 100

$("button#btn-stop").click ->
    root.ctx.clearRect(0, 0, root.canvas.width, root.canvas.height)
