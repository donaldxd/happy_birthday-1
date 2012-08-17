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


