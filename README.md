# SpeedCrunch Imperial

SpeedCrunch Imperial is a practical fork of [SpeedCrunch](https://bitbucket.org/heldercorreia/speedcrunch/) for people who do shop, fabrication, estimating, and field math in feet, inches, fractions, and material weights.

The goal is simple: keep SpeedCrunch fast and precise, but make common imperial workflows less annoying.

## What This Fork Adds

- Foot/inch input such as `12'3"`, `12'-3"`, `12'-3 1/2"`, and `124.375"`.
- Imperial length output as feet, inches, and reduced fractions.
- Better behavior when length math produces area, such as `12'3*12'3`.
- Material density variables for quick weight estimates.
- Linux and Windows builds through GitHub Actions.

The original SpeedCrunch scientific calculator behavior is still the base. This fork is not trying to turn SpeedCrunch into a CAD package or estimating suite; it is meant to make everyday calculator work smoother.

## Downloads

Open the repository's **Actions** tab and download the artifact from the latest successful build.

- **Linux:** `SpeedCrunch-Imperial-Linux-x64`
- **Windows portable ZIP:** `SpeedCrunch-Imperial-Windows-x64`
- **Windows installer:** `SpeedCrunch-Imperial-Windows-x64-Installer`

Tagged releases named like `v1.0.0` attach the Windows ZIP and installer to the GitHub Release.

The Windows executable is named `speedcrunch-imperial.exe` so it can live beside an official SpeedCrunch install.

## Imperial Length Examples

These inputs are accepted:

```text
75'2" + 32'
32'-1"
32'-1 3/4"
32'-0.75"
32'0.875"
124.375"
32'0"+123.34
```

When an expression uses quote-style imperial length, plain decimal numbers in the same addition or subtraction expression are treated as inches:

```text
32'0"+123.34
```

means:

```text
32 feet + 0 inches + 123.34 inches
```

## Output Examples

| Input | Output |
| --- | --- |
| `75'2" + 32'` | `107'-2"` |
| `32'0"+123.34` | `42'-3 11/32"` |
| `124.375"` | `10'-4 3/8"` |
| `32'-1 3/4"` | `32'-1 3/4"` |
| `32'-0.75"` | `32'-3/4"` |
| `32'0.875"` | `32'-7/8"` |
| `12'3*12'3` | `150.0625[ft²]` |
| `12'3/3'` | `4.08333333333333333333` |
| `sqrt(12'3*12'3)` | `12'-3"` |

Imperial length output is rounded to the nearest 1/64 inch and fractions are reduced.

## Material Density Variables

These variables are available in the calculator:

| Variable | Value |
| --- | --- |
| `steel_density` | `0.283 lb/in³` |
| `alu_density` | `0.0975 lb/in³` for aluminum 6061 |
| `ss_density` | `0.289 lb/in³` for stainless 304 |

Example:

```text
2 * 4 * 12 * steel_density
```

## Auto-Ans Tip

SpeedCrunch can automatically insert `ans` when a new expression starts with an operator. For example, after a calculation, typing `*2` can become `ans*2`.

If you want that behavior, enable:

```text
Settings -> Behavior -> Auto-Insert "ans" When Starting with an Operator
```

## Building Locally

Linux/CachyOS or Arch:

```sh
sudo pacman -S --needed base-devel cmake ninja qt6-base qt6-tools
./tools/build-cachyos.sh
```

Windows from a Visual Studio 2022 developer shell:

```powershell
powershell -ExecutionPolicy Bypass -File .\tools\build-windows.ps1 -Package
```

More build details are in [BUILDING-FORK.md](BUILDING-FORK.md).

## Project Status

This is a fork for practical imperial workflows. Expect the core calculator to stay close to SpeedCrunch while the imperial parsing, formatting, and shop-math conveniences improve over time.

Bug reports with exact expressions are the most useful kind. Include the input, the output you got, and the output you expected.

## Upstream and License

SpeedCrunch is a high-precision scientific calculator. Upstream is available at:

https://bitbucket.org/heldercorreia/speedcrunch/

This fork keeps the upstream GPL license terms. See [LICENSE](LICENSE).
