.PHONY: build default test
.PHONY: prepare prepare.haxelib
.PHONY: flash.build flash.run
.PHONY: flash11.build flash11.test

default: build

prepare: prepare.haxelib

prepare.haxelib:
	./tools/prepare.haxelib.sh

build:
	./tools/build.sh

test:
	./tools/test.sh

flash.build:
	./tools/flash.build.sh

flash.run:
	./tools/flash.run.sh

flash11.build:
	./tools/flash11.build.sh

flash11.test:
	./tools/flash11.test.sh
