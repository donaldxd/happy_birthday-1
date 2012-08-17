class Board
    constructor: () ->
        w = root.canvas.width
        h = root.canvas.height
        @v1 = new Vector(w*3/8, h/8)
        @v2 = new Vector(w*5/8, h/8)
        @v3 = new Vector(w*5/16,h/4)
        @v4 = new Vector(w*11/16,h/4)
        @v5 = new Vector(w/4, h/4)
        @width = w/2

    showBoard: ->
        @v1.fillCircle()
        @v2.fillCircle()
        root.ctx.save()
        root.ctx.strokeStyle = commonColor.yellow
        root.ctx.lineWidth = 5
        root.ctx.beginPath()
        root.ctx.moveTo @v1.x, @v1.y
        root.ctx.lineTo @v3.x, @v3.y
        root.ctx.closePath()
        root.ctx.stroke()

        root.ctx.beginPath()
        root.ctx.moveTo @v2.x, @v2.y
        root.ctx.lineTo @v4.x, @v4.y
        root.ctx.closePath()
        root.ctx.stroke()

        root.ctx.fillStyle = commonColor.darkGreen
        root.ctx.strokeStyle = commonColor.saddleBrown
        root.ctx.lineWidth = 10
        root.ctx.fillRect(@v5.x, @v5.y, root.canvas.width/2, root.canvas.height/2)
        root.ctx.strokeRect(@v5.x, @v5.y, root.canvas.width/2, root.canvas.height/2)
        root.ctx.restore()
        return

    showMessage: (msg) ->
        clearCanvas()
        @showBoard()
        root.ctx.save()
        root.ctx.fillStyle = commonColor.white
        root.ctx.strokeStyle = commonColor.white
        root.ctx.font = "oblique normal lighter 64px monoca monospace"
        msgWidth = root.ctx.measureText(msg).width
        startX = root.canvas.width/4 + (@width - msgWidth)/2
        #root.ctx.fillText(msg, startX, root.canvas.height/2)
        root.ctx.strokeText(msg, startX, root.canvas.height/2)
        root.ctx.restore()
        return



root.board = new Board()
