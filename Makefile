COFFEEC=coffee -c

all:
	$(COFFEEC) -j js/all.js -c js/root.coffee js/helpers.coffee js/constants.coffee js/data.coffee js/vector.coffee js/board.coffee js/cake.coffee js/leaf.coffee js/flower.coffee js/main.coffee
