#define global variable, ctx, canvas, set width and height
root = global ? window
root.canvas = $("#canvas")[0]
root.canvas.width = root.innerWidth
root.canvas.height = root.innerHeight
root.ctx = root.canvas.getContext "2d"


class Helper
    @random: (min, max) ->
        return Math.random() * (max - min) + min

    @randomInt: (min, max) ->
        return Math.floor(Math.random() * (max - min)) + min

    @rgba: (r,g,b,a) ->
        return "rgba(#{r},#{g},#{b},#{a})"
    
    @randomrgba: (min, max, a) ->
        return Helper.rgba Math.round(Helper.random(min, max)), Math.round(Helper.random(min, max)), Math.round(Helper.random(min, max)), a

    @deg2rad: (deg) ->
        return Math.PI / 180 * deg

    @rad2deg: (rad) ->
        return rad / Math.PI * 180

    @previewColor = "rgba(127,127,127,0.4)"
    @minBloomRadius = 5
    @maxBloomRadius = 20
    @minPetalStretch = 0.1
    @maxPetalStretch = 3
    @minPetalCount = 5
    @maxPetalCount = 15
    @minGrowFactor = 0.1
    @maxGrowFactor = 1
    @minColor = 0
    @maxColor = 255
    @opacity = 0.5
    @density = 10
    @growSpeed = 166
    @tanAngle = 90




class Vector
    constructor: (x,y) ->
        @x = x
        @y = y

    rotate: (theta) ->
        x = @x
        y = @y
        @x = Math.cos(theta) * x - Math.sin(theta) * y
        @y = Math.sin(theta) * x + Math.cos(theta) * y
        return @

    mult: (f) ->
        @x *= f
        @y *= f
        return @

    clone: ->
        return new Vector(@x, @y)

    length: ->
        return Math.sqrt(@x * @x + @y * @y)

    subtract: (v) ->
        @x -= v.x
        @y -= v.y
        return @

    set: (x, y) ->
        @x = x
        @y = y
        return @



class Petal

    constructor: (stretchA, stretchB, startAngle, angle, growFactor, bloom) ->
        @stretchA = stretchA
        @stretchB = stretchB
        @startAngle = startAngle
        @angle = angle
        @bloom = bloom
        @growFactor = growFactor
        @r = 1
        @isFinished = false

    draw: ->
        #ctx = root.ctx
        v1 = new Vector(0, @r).rotate(Helper.deg2rad @startAngle)
        v2 = v1.clone().rotate(Helper.deg2rad @angle)
        v3 = v1.clone().mult(@stretChA)
        v4 = v2.clone().mult(@stretchB)
        console.log root.ctx
        root.ctx.beginPath()
        root.ctx.moveTo v1.x, v1.y
        root.ctx.bezierCurveTo v3.x, v3.y, v4.x, v4.y, v2.x, v2.y
        root.ctx.closePath()
        root.ctx.stroke()
        return

    render: ->
        #console.log @r
        if @r <= @bloom.r
            @r += @growFactor
            @draw()
        else
            @isFinished = true
        return


class Bloom

    constructor: (p, r, c, pc, garden) ->
        @p = p
        @r = r
        @c = c
        @pc = pc
        @garden = garden
        @petals = []
        @init()
        @garden.blooms.push @

    draw: ->
        isFinished = true
        root.ctx.save()
        root.ctx.translate(@p.x, @p.y)
        for petal in @petals
            petal.render()
            isFinished = petal.isFinished and isFinished
        if isFinished
            @garden.removeBloom @
        root.ctx.restore()
        return

    init: ->
        angle = 360.0 / @pc
        startAngle = Helper.randomInt 0, 90
        for i in [0...@pc]
            p = new Petal Helper.random(Helper.minPetalStretch, Helper.maxPetalStretch), Helper.random(Helper.minPetalStretch, Helper.maxPetalStretch), startAngle + i * angle, angle, Helper.random(Helper.minGrowFactor, Helper.maxGrowFactor), @
            @petals.push p
                


class Garden

    constructor: () ->
        @ctx = root.ctx
        @blooms = []

    addBloom: (b) ->
        @blooms.push b

    removeBloom: (b) ->
        for i in [0...(@blooms.length)]
            if b == @blooms[i]
                @blooms.splice(i,1)
                return @

    render: ->
        for bloom in @blooms
            bloom.draw()
        return

    clear: ->
        @blooms = []
        @ctx.clearRect(0, 0, root.canvas.width, root.canvas.height)
        return

    createBloom: (x, y, r, c, pc) ->
        new Bloom(new Vector(x,y), r, c, pc, @)

    createRandomBloom: (x, y) ->
        @createBloom x, y, Helper.randomInt(Helper.minBloomRadius, Helper.maxBloomRadius), Helper.randomrgba(Helper.minColor, Helper.maxColor, Helper.opacity), Helper.randomInt(Helper.minPetalCount, Helper.maxPetalCount)






main = ->
    g = new Garden()
    g.createRandomBloom(100, 100)
    console.log g
    g.render()
    return


test = ->
    p = new Petal 3, 0.5, 0, 45, 1, null
    root.ctx.save()
    root.ctx.translate(100,100)
    p.draw()
    root.ctx.restore()
    return

test()
#main()
