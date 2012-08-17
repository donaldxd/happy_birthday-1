class Leaf
    constructor: (s1, s2, startAngle, angle, growth, flower) ->
        @s1 = s1
        @s2 = s2
        @startAngle = startAngle
        @angle = angle
        @r = 1
        @growth = growth
        @flower = flower
        @color = randColor()
        #@color = commonColor.red

    randomize: (startAngle)->
        @s1 = random stretch.min, stretch.max
        @s2 = random stretch.min, stretch.max
        @growth = random growth.min, growth.max
        @startAngle = startAngle
        @color = randColor()
        #@color = commonColor.red
        return

    draw: ->
        v1 = new Vector(@r,0).rotate(@startAngle)
        v2 = v1.clone().rotate(@angle)
        v3 = v1.clone().mult(@s1)
        v4 = v2.clone().mult(@s2)
        root.ctx.save()
        root.ctx.translate(@flower.center.x, @flower.center.y)
        root.ctx.strokeStyle = @color
        root.ctx.beginPath()
        root.ctx.moveTo v1.x, v1.y
        root.ctx.bezierCurveTo v3.x, v3.y, v4.x, v4.y, v2.x, v2.y
        root.ctx.closePath()
        root.ctx.stroke()
        root.ctx.restore()
        return

    render: ->
        r = @r
        while @r <= @flower.r
            @draw()
            @r += @growth
        @r = r
        return


