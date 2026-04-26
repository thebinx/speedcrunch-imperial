# SpeedCrunch Imperial Fork

This is a practical fork of [SpeedCrunch](https://bitbucket.org/heldercorreia/speedcrunch/) for shop and fabrication math. It keeps the original high-precision calculator and adds imperial length input/output plus common material density variables.

## Downloads

Windows builds are produced by GitHub Actions.

- Open the **Actions** tab.
- Select **Windows Portable Build**.
- Open the latest successful run.
- Download the `SpeedCrunch-Imperial-Windows-x64` artifact.
- Extract `SpeedCrunch-Imperial-Windows-x64.zip` and run `speedcrunch.exe`.

Tagged releases named like `v1.0.0` also attach the Windows ZIP to the GitHub Release.

## Added Variables

These variables are available immediately in the calculator:

| Variable | Value |
| --- | --- |
| `steel_density` | `0.283 lb/in³` |
| `alu_density` | `0.0975 lb/in³` for aluminum 6061 |
| `ss_density` | `0.289 lb/in³` for stainless 304 |

Example:

```text
2 * 4 * 12 * steel_density
```

## Imperial Length Input

The fork accepts foot/inch quote syntax for length math. Internally these values are treated as inches, then formatted back as feet, inches, and reduced fractions when quote-style imperial input is used.

Accepted examples:

```text
75'2" + 32'
32'-1"
32'-1 3/4"
32'-0.75"
32'0.875"
124.375"
32'0"+123.34
```

When an expression contains foot/inch syntax, plain decimal numbers in the same addition/subtraction expression are treated as decimal inches. For example:

```text
32'0"+123.34
```

means:

```text
32 feet + 0 inches + 123.34 inches
```

## Imperial Length Output

Imperial length output is normalized to feet, inches, and the nearest 1/64 inch. Fractions are reduced automatically, so exact or near-exact common fractions display naturally.

Examples:

| Input | Output |
| --- | --- |
| `75'2" + 32'` | `107'-2"` |
| `32'0"+123.34` | `42'-3 11/32"` |
| `124.375"` | `10'-4 3/8"` |
| `32'-1 3/4"` | `32'-1 3/4"` |
| `32'-0.75"` | `32'-3/4"` |
| `32'0.875"` | `32'-7/8"` |

The original SpeedCrunch sexagesimal angle mode is preserved. In sexagesimal result mode, quote marks continue to behave as arcminute/arcsecond syntax.

## Building

Build instructions for Linux/CachyOS and Windows are in [BUILDING-FORK.md](BUILDING-FORK.md).

Quick CachyOS/Arch build:

```sh
sudo pacman -S --needed base-devel cmake ninja qt6-base qt6-tools
./tools/build-cachyos.sh
```

Quick Windows build from a Visual Studio 2022 developer shell:

```powershell
powershell -ExecutionPolicy Bypass -File .\tools\build-windows.ps1 -Package
```

## Upstream

SpeedCrunch is a high-precision scientific calculator. The upstream project is available at:

https://bitbucket.org/heldercorreia/speedcrunch/

This fork keeps the upstream license terms.

## License

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or at your option any later version.
