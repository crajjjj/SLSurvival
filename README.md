# SexLab Survival

<p align="center">
  <a href="https://crajjjj.github.io/SLSurvival/"><img src="https://img.shields.io/badge/docs-GitHub%20Pages-brightgreen?logo=readthedocs&logoColor=white" alt="Documentation"></a>
  <a href="https://github.com/crajjjj/SLSurvival/actions/workflows/docs.yml"><img src="https://github.com/crajjjj/SLSurvival/actions/workflows/docs.yml/badge.svg" alt="Deploy docs"></a>
  <img src="https://img.shields.io/badge/version-0.700-blue" alt="Version 0.700">
  <img src="https://img.shields.io/badge/Skyrim-SE%2FAE-orange" alt="Skyrim SE/AE">
  <img src="https://img.shields.io/badge/scripting-pure%20Papyrus-8A2BE2" alt="Pure Papyrus">
  <a href="https://www.loverslab.com/files/file/5914-sexlab-survival/"><img src="https://img.shields.io/badge/LoversLab-download-red" alt="LoversLab"></a>
  <img src="https://img.shields.io/badge/content-18%2B-black" alt="18+ content"><br>
  <img src="https://img.shields.io/github/last-commit/crajjjj/SLSurvival" alt="Last commit">
  <img src="https://img.shields.io/github/languages/top/crajjjj/SLSurvival" alt="Top language">
  <img src="https://img.shields.io/github/repo-size/crajjjj/SLSurvival" alt="Repo size">
</p>

A large Skyrim SE gameplay and survival overhaul — needs, licences, tolls, misogyny, and dozens of optional LoversLab / survival mod integrations, all behind a resilient adapter layer. **Pure Papyrus**, no SKSE plugin of its own.

**Original author:** Monoman1.

> ⚠️ **Adult (18+) content.** Built on the SexLab framework and other LoversLab mods; not available on the Nexus.

## Documentation

Full docs (player guide + internals): **<https://crajjjj.github.io/SLSurvival/>**

Built from `docs/` and published to GitHub Pages by [`.github/workflows/docs.yml`](.github/workflows/docs.yml) on every push to `main`.

## Dev environment

- Setup manual — <https://gist.github.com/mrowrpurr/e164735e14ee6d07daf4f4217caf3714>
- Video walkthrough — <https://youtu.be/Hejm3TJw10E>
- Building a single changed script and the full import-list gotcha — see [Internals → Building from source](https://crajjjj.github.io/SLSurvival/internals/#building-from-source).

## References

- SexLab Survival thread — <https://www.loverslab.com/topic/99955-sexlab-survival/page/338/>
- Interfacing with the Frostfall script — <https://www.loverslab.com/topic/152261-interfacing-with-frostfall-script/>
- Unable to compile an SLS script — <https://www.loverslab.com/topic/154099-unable-to-compile-sls-script/>

## Recent changes

- `_SLS_IntSlso`: `OrgasmEffect()` arg fix
- `ma` and `sgo` obsolete
- `TIF__04057C32`: `Menu.Init.PpFailDevices` fix
- `BikiniArmors.json`: parked missing `LADX_SSE.esp` entries (stops the BuildBikinis 255-armors warning)
- RapeDrug / TollDrug: "FM Fertility" → "Fertility"; prefers Beeing Female Tonic when installed
- FOMOD: SunHelm StorageUtil patch folder
