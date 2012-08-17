root.initialize = ->
    for y in [3..6]
        root.data.push (new Vector(4,y))
        root.data.push (new Vector(5,y))
    for y in [7..8]
        root.data.push (new Vector(3,y))
        root.data.push (new Vector(4,y))
    for x in [2..3]
        root.data.push (new Vector(x,9))
    root.data.push (new Vector(3,10))

    for x in [4..17]
        root.data.push (new Vector(x,6))
        root.data.push (new Vector(x,7))

    for x in [5..16]
        root.data.push (new Vector(x,12))
        root.data.push (new Vector(x,13))

    for y in [2..19]
        root.data.push (new Vector(10,y))
        root.data.push (new Vector(11,y))

    for x in [2..19]
        root.data.push (new Vector(x,18))
        root.data.push (new Vector(x,19))
    #end of 生

    for y in [3..19]
        root.data.push (new Vector(25,y))
        root.data.push (new Vector(26,y))

    for x in [25..36]
        root.data.push (new Vector(x,3))
        root.data.push (new Vector(x,4))
    for y in [5..18]
        root.data.push (new Vector(35,y))
        root.data.push (new Vector(36,y))

    for x in [27..34]
        root.data.push (new Vector(x,9))
        root.data.push (new Vector(x,10))

    for x in [27..34]
        root.data.push (new Vector(x,17))
        root.data.push (new Vector(x,18))
    #end of 日
    
    for y in [6..10]
        root.data.push (new Vector(42,y))
        root.data.push (new Vector(43,y))

    for y in [2..19]
        root.data.push (new Vector(45,y))
        root.data.push (new Vector(46,y))

    for x in [47..48]
        root.data.push (new Vector(x,6))
    for x in [47..48]
        root.data.push (new Vector(x,7))
    for x in [48..49]
        root.data.push (new Vector(x,8))
    for x in [48..49]
        root.data.push (new Vector(x,9))

    for x in [50..57]
        root.data.push (new Vector(x,5))
        root.data.push (new Vector(x,6))
    for y in [7..10]
        root.data.push (new Vector(56,y))
        root.data.push (new Vector(57,y))

    for x in [49..59]
        root.data.push (new Vector(x,11))
        root.data.push (new Vector(x,12))

    for y in [2..14]
        root.data.push (new Vector(52,y))
        root.data.push (new Vector(53,y))
    for x in [51..52]
        root.data.push (new Vector(x,15))
    for x in [50..52]
        root.data.push (new Vector(x,16))
    for x in [49..51]
        root.data.push (new Vector(x,17))
    for x in [48..50]
        root.data.push (new Vector(x,18))
    for x in [48..49]
        root.data.push (new Vector(x,19))

    for x in [54..55]
        root.data.push (new Vector(x,14))
    for x in [54..56]
        root.data.push (new Vector(x,15))
    for x in [55..57]
        root.data.push (new Vector(x,16))
    for x in [56..58]
        root.data.push (new Vector(x,17))
    for x in [57..59]
        root.data.push (new Vector(x,18))
    for x in [58..59]
        root.data.push (new Vector(x,19))
    #end of 快

    for x in [76..73]
        root.data.push (new Vector(x,2))
        root.data.push (new Vector(x,3))
    for x in [72..64]
        root.data.push (new Vector(x,3))
        root.data.push (new Vector(x,4))

    for y in [5..8]
        root.data.push (new Vector(64,y))
        root.data.push (new Vector(65,y))
    for x in [63..78]
        root.data.push (new Vector(x, 9))
        root.data.push (new Vector(x, 10))

    for y in [6..18]
        root.data.push (new Vector(71,y))
        root.data.push (new Vector(72,y))
    root.data.push (new Vector(71,19))
    for x in [70..69]
        root.data.push (new Vector(x,18))
        root.data.push (new Vector(x,19))

    for x in [66..67]
        root.data.push (new Vector(x, 13))
    for x in [65..67]
        root.data.push (new Vector(x, 14))
    for x in [64..66]
        root.data.push (new Vector(x, 15))
    for x in [63..65]
        root.data.push (new Vector(x, 16))
    for x in [63..64]
        root.data.push (new Vector(x, 17))

    for x in [74..75]
        root.data.push (new Vector(x,13))
    for x in [74..76]
        root.data.push (new Vector(x,14))
    for x in [75..77]
        root.data.push (new Vector(x,15))
    for x in [76..78]
        root.data.push (new Vector(x,16))
    for x in [77..78]
        root.data.push (new Vector(x,17))
    #end of 乐
    

    for v in root.data
        v.x *= (root.canvas.width/80)
        v.y *= (root.canvas.height/40)
        flower = new Flower(v)
        root.flowers.push (flower)

    return

 
