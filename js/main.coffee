showFlowers = (n = 1000) ->
    clearCanvas()
    for i in [0...n]
        x = randInt 0, root.canvas.width
        y = randInt 0, root.canvas.height
        v = new Vector(x, y)
        flower = new Flower(v)
        flower.render()
    return

showHappyBirthday = ->
    clearCanvas()
    root.ctx.save()
    root.ctx.translate(0,root.canvas.height/4)
    for flower in root.flowers
        flower.randomize()
        flower.render()
    root.ctx.restore()
    return

animateHappyBirthday = ->
    if root.i == root.flowers.length
        root.i = 0
        root.ctx.clearRect 0, 0, root.canvas.width, root.canvas.height
    else
        root.ctx.save()
        root.ctx.translate(0,root.canvas.height/4)
        flower = root.flowers[root.i]
        flower.randomize()
        flower.render()
        root.i += 1
        root.ctx.restore()
    setTimeout animateHappyBirthday, 40

step0 = ->
    root.board.showMessage "满地鲜花为谁盛开？"
    root.button.html "Next"
    root.button.bind "click", ->
        step1()
        return
    return

step1 = ->
    showFlowers(999)
    root.button.bind "click", ->
        step2()
        return
    return

step2 = ->
    root.board.showMessage "精选24*24，只为祝你"
    root.button.bind "click", ->
        step3()
        return
    return

step3 = ->
    showHappyBirthday()
    root.button.bind "click", ->
        step4()
        return
    return

step4 = ->
    root.board.showMessage "送上生日蛋糕"
    root.button.bind "click", ->
        step5()
        return
    return

step5 = ->
    root.cake.render()
    root.button.bind "click", ->
        step6()
        return
    return

step6 = ->
    root.board.showMessage "最后的总是最华丽的"
    root.button.bind "click", ->
        step7()
        return
    return

step7 =->
    clearCanvas()
    animateHappyBirthday()
    root.button.html "Happy Birthday"
    root.button.attr "disabled", "disabled"

main = ->
    root.initialize()
    root.board.showMessage "点击底部的Start按钮开始"
    root.button.bind "click", ->
        step0()
        return
    return

main()
