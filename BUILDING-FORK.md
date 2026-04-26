# Building SpeedCrunch Imperial

This fork uses CMake and Qt 6. The checked-in presets keep Linux/CachyOS and Windows builds using the same source tree and install layout.

## GitHub Actions Builds

The repository includes GitHub Actions for Linux and Windows. On every push to `main`, GitHub builds:

- a Linux x64 install tree
- a Windows x64 portable ZIP
- a Windows x64 NSIS installer

To create a public downloadable release, push a version tag:

```sh
git tag v1.0.0
git push origin v1.0.0
```

The Windows workflow attaches the ZIP and installer to that GitHub Release.

## CachyOS / Arch Linux

Install dependencies:

```sh
sudo pacman -S --needed base-devel cmake ninja qt6-base qt6-tools
```

Build and install into `dist/linux`:

```sh
./tools/build-cachyos.sh
```

Debug build:

```sh
./tools/build-cachyos.sh linux-debug
```

Manual equivalent:

```sh
cmake -S src --preset linux-release
cmake --build build/linux-release --parallel
cmake --install build/linux-release
```

## Windows x64

Install:

- Visual Studio 2022 with "Desktop development with C++"
- CMake for Windows
- Qt 6 for MSVC 64-bit

Open "x64 Native Tools Command Prompt for VS 2022" or Developer PowerShell. If Qt is not installed under `C:\Qt`, set `CMAKE_PREFIX_PATH` first:

```powershell
$env:CMAKE_PREFIX_PATH = "D:\Qt\6.6.3\msvc2019_64"
```

Build and install into `dist\windows-msvc`:

```powershell
powershell -ExecutionPolicy Bypass -File .\tools\build-windows.ps1
```

Create a portable ZIP package:

```powershell
powershell -ExecutionPolicy Bypass -File .\tools\build-windows.ps1 -Package
```

Create an NSIS installer:

```powershell
powershell -ExecutionPolicy Bypass -File .\tools\build-windows.ps1 -Preset windows-msvc-installer -Package
```

The portable preset uses `PORTABLE_SPEEDCRUNCH=ON` and `CPACK_GENERATOR=ZIP`. The installer preset uses `PORTABLE_SPEEDCRUNCH=OFF` and `CPACK_GENERATOR=NSIS`, so it requires NSIS on the build machine. The GitHub Actions workflow installs NSIS automatically.
