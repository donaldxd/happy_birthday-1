root = window ? global
root.canvas = $("#canvas")[0]
root.ctx = root.canvas.getContext "2d"
root.canvas.width = root.innerWidth
root.canvas.height = root.innerHeight - 50
root.btn = $("#btn")[0]
root.modified = false
root.needAnimation = false
root.R = Math.min(root.innerWidth, root.innerHeight) * 0.45

stretch =
    min:0.3
    max:10.0

radius =
    min:3
    max:5

nleaf =
    min:3
    max:10

growth =
    min:0.1
    max:0.3


clearCanvas = ->
    root.ctx.clearRect 0, 0, root.canvas.width, root.canvas.height

random = (min = 0, max = 1) ->
    Math.random() * (max - min) + min

randInt = (min, max) ->
    Math.floor(Math.random() * (max - min)) + min

randColor = ->
    r = randInt(0, 255)
    g = randInt(0, 255)
    b = randInt(0, 255)
    a = random()
    #a = 0.5
    return "rgba(#{r},#{g},#{b},#{a})"

getColor = (r,g,b,a) -> "rgba(#{r},#{g},#{b},#{a})"

commonColor =
    red:"rgb(255,0,0)"
    green:"rgb(0,255,0)"
    blue:"rgb(0,0,255)"
    black:"rgb(0,0,0)"
    white:"rgb(255,255,255)"
    yellow:"rgb(255,255,0)"
    purple:"rgb(255,0,255)"
    deepPink:"rgb(255,20,147)"
    saddleBrown:"rgb(139,69,19)"
    darkGreen:"rgb(34,139,34)"
    mintCream:"rgb(245,255,250)"
    chocolate:"rgb(210,105,30)"

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

    fillCircle: (r=10, color=commonColor.red) ->
        root.ctx.save()
        root.ctx.translate(@x, @y)
        root.ctx.beginPath()
        root.ctx.arc(0, 0, r, 0, Math.PI * 2, true)
        root.ctx.closePath()
        root.ctx.fillStyle=color
        root.ctx.fill()
        root.ctx.restore()
        return

    getHeartCurvePoint: (r, theta=0) ->
        theta = Math.PI / 180 * theta
        x=@x+r*16*Math.pow(Math.sin(theta),3)
        y=@y-r*(13*Math.cos(theta)-5*Math.cos(2*theta)-2*Math.cos(3*theta)-Math.cos(4*theta))
        return new Vector(x,y)

    fillDiamond: (r, color=commonColor.yellow) ->
        root.ctx.save()
        root.ctx.translate(@x,@y)
        root.ctx.beginPath()
        root.ctx.moveTo(-r, 0)
        root.ctx.lineTo(0, -r)
        root.ctx.lineTo(r,0)
        root.ctx.lineTo(0,r)
        root.ctx.closePath()
        root.ctx.fillStyle = color
        root.ctx.fill()
        root.ctx.restore()
        return




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
    minWidth = 100
    maxWidth = Math.floor(root.canvas.width) - minWidth
    minHeight = 100
    maxHeight = Math.floor(root.canvas.height) - minHeight
    for i in [0..n]
        p = new Vector(randInt(minWidth, maxWidth), randInt(minHeight, maxHeight))
        f = new Flower(p, randInt(radius.min, radius.max), randInt(nleaf.min,nleaf.max))
        f.render()
    return


createData = ->
    data = []
    for y in [3..6]
        data.push (new Vector(4,y))
        data.push (new Vector(5,y))
    for y in [7..8]
        data.push (new Vector(3,y))
        data.push (new Vector(4,y))
    data.push (new Vector(2,9))
    data.push (new Vector(3,9))
    data.push (new Vector(3,10))

    for x in [4..17]
        data.push (new Vector(x,6))
        data.push (new Vector(x,7))

    for x in [5..16]
        data.push (new Vector(x,12))
        data.push (new Vector(x,13))

    for y in [2..19]
        data.push (new Vector(10,y))
        data.push (new Vector(11,y))

    for x in [2..19]
        data.push (new Vector(x,18))
        data.push (new Vector(x,19))
    #end of 生

    for y in [3..19]
        data.push (new Vector(25,y))
        data.push (new Vector(26,y))

    for x in [25..36]
        data.push (new Vector(x,3))
        data.push (new Vector(x,4))
    for y in [5..18]
        data.push (new Vector(35,y))
        data.push (new Vector(36,y))

    for x in [27..34]
        data.push (new Vector(x,9))
        data.push (new Vector(x,10))

    for x in [27..34]
        data.push (new Vector(x,17))
        data.push (new Vector(x,18))
    #end of 日
    
    for y in [6..10]
        data.push (new Vector(42,y))
        data.push (new Vector(43,y))

    for y in [2..19]
        data.push (new Vector(45,y))
        data.push (new Vector(46,y))

    data.push (new Vector(47,6))
    data.push (new Vector(48,6))
    data.push (new Vector(47,7))
    data.push (new Vector(48,7))
    data.push (new Vector(48,8))
    data.push (new Vector(49,8))
    data.push (new Vector(48,9))
    data.push (new Vector(49,9))

    for x in [50..57]
        data.push (new Vector(x,5))
        data.push (new Vector(x,6))
    for y in [7..10]
        data.push (new Vector(56,y))
        data.push (new Vector(57,y))

    for x in [49..59]
        data.push (new Vector(x,11))
        data.push (new Vector(x,12))

    for y in [2..14]
        data.push (new Vector(52,y))
        data.push (new Vector(53,y))
    data.push (new Vector(51,15))
    data.push (new Vector(52,15))
    data.push (new Vector(50,16))
    data.push (new Vector(51,16))
    data.push (new Vector(52,16))
    data.push (new Vector(49,17))
    data.push (new Vector(50,17))
    data.push (new Vector(51,17))
    data.push (new Vector(48,18))
    data.push (new Vector(49,18))
    data.push (new Vector(50,18))
    data.push (new Vector(48,19))
    data.push (new Vector(49,19))

    data.push (new Vector(54,13))
    data.push (new Vector(54,14))
    data.push (new Vector(55,14))
    data.push (new Vector(54,15))
    data.push (new Vector(55,15))
    data.push (new Vector(56,15))
    data.push (new Vector(55,16))
    data.push (new Vector(56,16))
    data.push (new Vector(57,16))
    data.push (new Vector(56,17))
    data.push (new Vector(57,17))
    data.push (new Vector(58,17))
    data.push (new Vector(57,18))
    data.push (new Vector(58,18))
    data.push (new Vector(59,18))
    data.push (new Vector(58,19))
    data.push (new Vector(59,19))
    
    #end of 快

    for x in [76..73]
        data.push (new Vector(x,2))
        data.push (new Vector(x,3))
    for x in [72..64]
        data.push (new Vector(x,3))
        data.push (new Vector(x,4))

    for y in [5..8]
        data.push (new Vector(64,y))
        data.push (new Vector(65,y))
    for x in [63..78]
        data.push (new Vector(x, 9))
        data.push (new Vector(x, 10))

    for y in [6..18]
        data.push (new Vector(71,y))
        data.push (new Vector(72,y))
    data.push (new Vector(71,19))
    for x in [70..69]
        data.push (new Vector(x,18))
        data.push (new Vector(x,19))

    for x in [66..67]
        data.push (new Vector(x, 13))
    for x in [65..67]
        data.push (new Vector(x, 14))
    for x in [64..66]
        data.push (new Vector(x, 15))
    for x in [63..65]
        data.push (new Vector(x, 16))
    for x in [63..64]
        data.push (new Vector(x, 17))

    for x in [74..75]
        data.push (new Vector(x,13))
    for x in [74..76]
        data.push (new Vector(x,14))
    for x in [75..77]
        data.push (new Vector(x,15))
    for x in [76..78]
        data.push (new Vector(x,16))
    for x in [77..78]
        data.push (new Vector(x,17))

    #end of 乐
    return data

root.letterData = createData()
root.i = 0

modifyData = ->
    if root.modified
        return
    mult_x = root.canvas.width / 80
    mult_y = root.canvas.height / 40
    for v in root.letterData
        v.x *= mult_x
        v.y *= mult_y
    root.modified = true
    return

writeLetter = ->
    if root.i == root.letterData.length
        root.i = 0
        root.needAnimation = false
        root.ctx.clearRect 0, 0, root.canvas.width, root.canvas.height
        #return
    else
        root.ctx.save()
        root.ctx.translate(0,root.canvas.height/4)
        v = root.letterData[root.i]
        #f = new Flower(v, randInt(radius.min, radius.max), randInt(nleaf.min,nleaf.max))
        f = new Flower(v, randInt(radius.min, 7), randInt(nleaf.min,nleaf.max))
        f.render()
        root.i += 1
        root.ctx.restore()
    setTimeout writeLetter, 40

showLetter = ->
    root.ctx.save()
    root.ctx.translate(0,root.canvas.height/4)
    for v in root.letterData
        f = new Flower(v, randInt(radius.min, radius.max), randInt(nleaf.min,nleaf.max))
        #f = new Flower(v, randInt(radius.min, 7), randInt(nleaf.min,nleaf.max))
        f.render()
    root.ctx.restore()
    return


showBoard = ->
    w = root.canvas.width
    h = root.canvas.height
    v1 = new Vector(w*3/8, h/8)
    v2 = new Vector(w*5/8, h/8)
    v3 = new Vector(w*5/16,h/4)
    v4 = new Vector(w*11/16,h/4)
    v1.fillCircle()
    v2.fillCircle()
    root.ctx.save()
    root.ctx.strokeStyle = commonColor.yellow
    root.ctx.lineWidth = 5
    root.ctx.beginPath()
    root.ctx.moveTo v1.x, v1.y
    root.ctx.lineTo v3.x, v3.y
    root.ctx.closePath()
    root.ctx.stroke()

    root.ctx.beginPath()
    root.ctx.moveTo v2.x, v2.y
    root.ctx.lineTo v4.x, v4.y
    root.ctx.closePath()
    root.ctx.stroke()

    v5 = new Vector(w/4, h/4)
    root.ctx.fillStyle = commonColor.darkGreen
    root.ctx.strokeStyle = commonColor.saddleBrown
    root.ctx.lineWidth = 10
    root.ctx.fillRect(v5.x, v5.y, w/2, h/2)
    root.ctx.strokeRect(v5.x, v5.y, w/2, h/2)
    root.ctx.restore()
    return

showMessage = (msg) ->
    clearCanvas()
    showBoard()
    root.ctx.save()
    root.ctx.fillStyle = commonColor.white
    root.ctx.strokeStyle = commonColor.white
    root.ctx.font = "oblique normal lighter 64px monoca monospace"
    msgWidth = root.ctx.measureText(msg).width
    boardWidth = root.canvas.width/2
    startX = root.canvas.width/4 + (boardWidth - msgWidth)/2
    #root.ctx.fillText(msg, startX, root.canvas.height/2)
    root.ctx.strokeText(msg, startX, root.canvas.height/2)
    root.ctx.restore()
    return

showCake = ->
    clearCanvas()
    p = new Vector(root.canvas.width/2, root.canvas.height/2)
    p.fillCircle(root.R, commonColor.chocolate)
    thetas = [0, 30, 45, 60, 75, 90, 100, 110, 120, 130, 140, 150, 180, 210, 220, 230, 240, 250, 260, 270, 285, 300, 315, 330]
    r = R*0.05
    for theta in thetas
        c = p.getHeartCurvePoint(r, theta)
        c.fillCircle(r)
        c.fillDiamond(r/3)
    return
    

step0 = ->
    showMessage("满地鲜花为谁盛开？")
    $("#btn").html "next"
    $("#btn").click ->
        step1()
        return
    return

step1 = ->
    clearCanvas()
    #$("#btn").attr "disabled", "disabled"
    showRandomFlowers(1000)
    #$("#btn").attr "disabled", "enabled"
    $("#btn").click ->
        step2()
        return
    return

step2 = ->
    showMessage("精选24*24，只为祝你")
    $("#btn").click ->
        step3()
        return
    return

step3 = ->
    clearCanvas()
    #$("#btn").attr "disabled", "disabled"
    modifyData()
    #root.needAnimation = true
    showLetter()
    #$("#btn").attr "disabled", "enabled"
    $("#btn").click ->
        step4()
        return
    return

step4 = ->
    showMessage "送上生日蛋糕"
    $("#btn").click ->
        step5()
        return
    return

step5 = ->
    showCake()
    $("#btn").click ->
        step6()
        return
    return

step6 = ->
    showMessage "最后的总是最华丽的"
    $("#btn").click ->
        step7()
        return
    return

step7 = ->
    clearCanvas()
    modifyData()
    root.needAnimation = true
    writeLetter()
    $("#btn").attr "disabled", "disabled"
    $("#btn").html "thank you"


main = ->
    #step0()
    #showCake()
    modifyData()
    writeLetter()
    return

main()
