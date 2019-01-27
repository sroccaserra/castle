
include .env
export

.PHONY: start-pico8
start-pico8:
	$(PICO8) -home $(shell pwd)
