-include .env
export

PICO_8 ?= $(HOME)/Applications/Games/PICO-8/PICO-8.app/Contents/MacOS/pico8

LUA_FILES := $(wildcard carts/*.lua)

.PHONY: test
test: tmp/castle.lua
	docker run --rm -t -v $(shell pwd):/app -w /app castle-test busted

tmp/castle.lua: $(LUA_FILES)
	mkdir -p tmp
	cat carts/*.lua > tmp/castle.lua

build:
	docker build -t castle-test .

.PHONY: run
run:
	$(PICO_8) -root_path carts -run carts/castle.p8

