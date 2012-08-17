clearCanvas = ->
    root.ctx.clearRect 0, 0, root.canvas.width, root.canvas.height

random = (min=0, max=1) ->
    Math.random() * (max - min) + min

randInt = (min, max) ->
    Math.floor(Math.random() * (max - min)) + min

randColor = ->
    r = randInt(0, 255)
    g = randInt(0, 255)
    b = randInt(0, 255)
    #a = 0.5
    a = random()
    return "rgba(#{r},#{g},#{b},#{a})"

getColor = (r,g,b,a) ->
    return "rgba(#{r},#{g},#{b},#{a})"
