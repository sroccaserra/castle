-include .env
export

PICO_8 ?= $(HOME)/Applications/Games/PICO-8/PICO-8.app/Contents/MacOS/pico8

.PHONY: start-pico8
start-pico8:
	$(PICO_8) -root_path carts -run carts/castle.p8

tmp/castle.lua: carts/castle.p8
	mkdir -p tmp
	sed -n -e '/__lua__/{' -e ':a' -e 'n' -e '/__gfx__/b' -e 'p' -e 'ba' -e '}' carts/castle.p8 > tmp/castle.lua

build:
	docker build -t castle-test .

.PHONY: test
test: tmp/castle.lua
	docker run --rm -t -v $(shell pwd):/app -w /app castle-test busted
