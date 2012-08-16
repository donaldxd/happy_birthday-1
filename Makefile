COFFEEC=coffee -c
SRC=$(wildcard js/*.coffee)
OBJ=$(patsubst %.coffee, %.js, $(SRC))



all:$(OBJ)
	@open index.html

$(OBJ): %.js: %.coffee
	$(COFFEEC) $<

