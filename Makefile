.PHONY: build clean default dist test
.PHONY: prepare prepare.haxelib
.PHONY: test test.flash11
.PHONY: build build.flash8
.PHONY: start.flash8

default: test

prepare: prepare.haxelib

prepare.haxelib:
	./tools/prepare.haxelib.sh

clean:
	./tools/clean.sh

test: test.flash11

test.flash11:
	./tools/test.flash11.sh

build: build.flash8

build.flash8:
	./tools/build.flash8.sh

start.flash8: build.flash8
	./tools/run.flash8.sh

dist: test
	./tools/dist.sh
