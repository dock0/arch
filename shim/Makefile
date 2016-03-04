.PHONY : default build clean

default: build

clean:
	rm shim

build: clean
	musl-gcc main.c -o shim -static
	strip shim

