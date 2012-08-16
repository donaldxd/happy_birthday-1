root = global ? window
root.canvas = $("#canvas")[0]
console.log root.canvas
root.canvas.width = root.innerWidth
root.canvas.height = root.innerHeight
root.ctx = root.canvas.getContext "2d"
root.R = Math.min(root.innerWidth, root.innerHeight) * 0.45
root.onFire = false

class Color
    constructor: (r=0,g=0,b=0) ->
        @r = r
        @g = g
        @b = b

    color: -> "rgb(#{@r},#{@g},#{@b})"

    @redColor = "rgb(255,0,0)"
    @greenColor = "rgb(0,255,0)"
    @blueColor = "rgb(0,0,255)"
    @blackColor = "rgb(0,0,0)"
    @whiteColor = "rgb(255,255,255)"
    @yellowColor = "rgb(255,255,0)"


class Pen
    constructor: (x=root.canvas.width/2, y=root.canvas.height/2, fillColor=Color.redColor, strokeColor=Color.greenColor) ->
        @x = x
        @y = y
        @ctx = root.ctx
        @ctx.fillStyle = fillColor
        @ctx.strokeStyle = strokeColor

    setX: (x) -> @x = x

    setY: (y) -> @y = y

    setXY: (x, y) ->
        @x = x
        @y = y

    log: ->
        console.log "point: (#{@x}, #{@y})"

    strokeCircle: (r, color="") ->
        if color == ""
            color = @ctx.strokeStyle
        @ctx.save()
        @ctx.strokeStyle = color
        @ctx.beginPath()
        @ctx.arc(@x, @y, r, 0, Math.PI*2, true)
        @ctx.closePath()
        @ctx.stroke()
        @ctx.restore()
        return

    fillCircle: (r) ->
        @ctx.beginPath()
        @ctx.arc(@x, @y, r, 0, Math.PI*2, true)
        @ctx.closePath()
        @ctx.stroke()
        @ctx.fill()
        return

    getHeartCurvePoint: (r, theta=0) ->
        theta = Math.PI / 180 * theta
        x=@x+r*16*Math.pow(Math.sin(theta),3)
        y=@y-r*(13*Math.cos(theta)-5*Math.cos(2*theta)-2*Math.cos(3*theta)-Math.cos(4*theta))
        new Pen(x, y)

    fillDiamond: (w,h, r=0) ->
        @ctx.save()
        @ctx.fillStyle = Color.yellowColor
        @ctx.beginPath()
        @ctx.moveTo(@x, @y-r)
        @ctx.lineTo(@x-w, @y-h-r)
        @ctx.lineTo(@x, @y-2*h-r)
        @ctx.lineTo(@x+w, @y-h-r)
        @ctx.closePath()
        @ctx.fill()
        @ctx.restore()
        return


main = ->
    pen = new Pen()
    R = root.R
    console.log R
    r = R * 0.05
    _color = new Color(255,255,0)
    pen.strokeCircle R, _color.color()
    thetas = [0, 30, 45, 60, 75, 90, 100, 110, 120, 130, 140, 150, 180, 210, 220, 230, 240, 250, 260, 270, 285, 300, 315, 330]
    for theta in thetas
        #console.log theta
        p = pen.getHeartCurvePoint(r, theta)
        #p.log()
        p.fillCircle(r)
        p.fillDiamond(r,r)
    console.log root.palette
#main()
