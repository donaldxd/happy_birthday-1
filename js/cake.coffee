class Cake
    constructor: () ->
        @center = new Vector(root.canvas.width/2, root.canvas.height/2)
        thetas = [0, 30, 45, 60, 75, 90, 100, 110, 120, 130, 140, 150, 180, 210, 220, 230, 240, 250, 260, 270, 285, 300, 315, 330]
        @candles = []
        r = root.cakeRadius / 20
        for theta in thetas
            @candles.push  @center.getHeartCurvePoint(r, theta)

    render: ->
        clearCanvas()
        r = root.cakeRadius / 20
        #root.ctx.save()
        #g = root.ctx.createRadialGradient @center.x, @center.y, root.cakeRadius/2, @center.x, @center.y, root.cakeRadius
        #g.addColorStop 0, commonColor._chocolate
        #g.addColorStop 0.9, commonColor._deepPink
        #g.addColorStop 1, commonColor._mintCream
        #root.ctx.beginPath()
        #root.ctx.arc @center.x, @center.y, root.cakeRadius, 0, Math.PI * 2, true
        #root.ctx.closePath()
        #root.ctx.fillStyle = g
        #root.ctx.fill()
        #root.ctx.restore()
        @center.fillCircle root.cakeRadius, commonColor.chocolate
        for candle in @candles
            candle.fillCircle(r)
            candle.fillDiamond(r/3)
        return

root.cake = new Cake()
