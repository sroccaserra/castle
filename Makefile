
include .env
export

.PHONY: start-pico8
start-pico8:
	$(PICO8) -home $(shell pwd)

tmp/castle.lua: carts/castle.p8
	mkdir -p tmp
	sed -n -e '/__lua__/{' -e ':a' -e 'n' -e '/__gfx__/b' -e 'p' -e 'ba' -e '}' carts/castle.p8 > tmp/castle.lua

build:
	docker build -t castle-test .

.PHONY: test
test: tmp/castle.lua
	docker run --rm -t -v $(shell pwd):/app -w /app castle-test busted
