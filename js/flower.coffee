class Flower
    constructor: (center) ->
        @center = center
        @r = randInt radius.min, radius.max
        @nLeaf = randInt nleaf.min, nleaf.max
        @leaves = []
        @initialize()

    addLeaf: (leaf) ->
        @leaves.push leaf

    initialize: ->
        startAngle = randInt(0, 360)
        angle = 360.0 / @nLeaf
        for i in [0...@nLeaf]
            leaf = new Leaf(random(stretch.min, stretch.max), random(stretch.min, stretch.max), startAngle, angle, random(growth.min,growth.max), @)
            @addLeaf leaf
            startAngle += angle
        return

    randomize: ->
        startAngle = randInt(0, 360)
        angle = 360.0 / @nLeaf
        for i in [0...@nLeaf]
            @leaves[i].randomize startAngle
            startAngle += angle
        @r = randInt radius.min, radius.max
        return

    render: ->
        for leaf in @leaves
            leaf.render()
        return

