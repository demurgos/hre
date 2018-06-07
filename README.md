# HRE: Haxe Regular Expressions

Pure Haxe Regular Expression Engine based on ES7-core.

This is a pure Haxe implementation that guarantees full reproducibility of the
results across all the targets (as opposed to the [EReg](http://api.haxe.org/EReg.html)
class from the standard library). You should note that to ensure reproducibility
across all targets you may get slower results.

Currently, **this library passes all the official ES7 RegExp tests** (see [Test262](https://github.com/tc39/test262/)),
except for one test that involves a very complex RegExp and fails due to performance
issues (timeout).

The next goal would be to introduce some differences with the ES7 spec to use Unicode
as the primary text representation and support Unicode grapheme clusters. Now that
the baseline is implemented, work on the performance of the engine is also planned.

Requires Haxe 3.1.

## Installation

Install it from haxelib:

```shell
haxelib install hre 0.1.3
```

## Usage

**Help wanted: improve the documentation**

## `new hre.RegExp(patternSource, flags)`

Create a new RegExp

## `regExp.exec(inputString)`

Execute the regular expression on the provided input string and return the result
with the matched slice and capture groups.

## `regExp.test(inputString)`

Returns a boolean indicating if the inputString is matched by the regExp.

## Build and develop

See [CONTRIBUTING.md](./CONTRIBUTING.md)
