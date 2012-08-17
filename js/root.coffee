root = window ? global

#set canvas and context
root.canvas = $("#canvas")[0]
root.ctx = root.canvas.getContext "2d"

#set canvas width and height
root.canvas.width = root.innerWidth
root.canvas.height = root.innerHeight - 50

#set cake radius
root.cakeRadius = Math.min(root.canvas.width, root.canvas.height) * 0.45

#set "happy birthday pattern positions"
root.data = []

#set flowers
root.flowers = []

#set button
root.button = $("#btn")

#cake instance
root.cake = null

#flower animation index
root.i = 0
