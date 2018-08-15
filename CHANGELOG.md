## 0.2.0 (2018-08-15)

- **[Breaking change]**: Use `hre.HreError` instead of `tink_core.Error` as the base error class.
- **[Patch]**: Drop all dependencies: the library is now self-contained. ([#5](https://gitlab.com/demurgos/hre/issues))
- **[Internal]** Add `CHANGELOG.md`
- **[Internal]** Refactor build tools, move more orchestration logic to the `Makefile`
- **[Internal]** Add Haxe 3.4 to the versions checked by CI
- **[Internal]** Read version from `haxelib.json` instead of duplicate `VERSION.txt` while building package
