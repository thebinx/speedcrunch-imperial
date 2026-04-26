param(
    [string]$Preset = "windows-msvc-release",
    [switch]$Package
)

$ErrorActionPreference = "Stop"
$Root = Resolve-Path (Join-Path $PSScriptRoot "..")

if (-not (Get-Command cmake -ErrorAction SilentlyContinue)) {
    throw "CMake is not on PATH. Install CMake for Windows and reopen this shell."
}

if (-not (Get-Command cl.exe -ErrorAction SilentlyContinue)) {
    throw "MSVC cl.exe is not on PATH. Run this from 'x64 Native Tools Command Prompt for VS 2022' or Developer PowerShell."
}

if (-not $env:CMAKE_PREFIX_PATH -and -not $env:Qt6_DIR) {
    $QtRoot = "C:\Qt"
    if (Test-Path $QtRoot) {
        $Candidate = Get-ChildItem $QtRoot -Directory |
            Sort-Object Name -Descending |
            ForEach-Object {
                Get-ChildItem $_.FullName -Directory -ErrorAction SilentlyContinue |
                    Where-Object { $_.Name -like "msvc*_64" } |
                    Select-Object -First 1
            } |
            Select-Object -First 1

        if ($Candidate) {
            $env:CMAKE_PREFIX_PATH = $Candidate.FullName
        }
    }
}

if (-not $env:CMAKE_PREFIX_PATH -and -not $env:Qt6_DIR) {
    throw "Qt 6 was not found. Set CMAKE_PREFIX_PATH to your Qt MSVC folder, for example C:\Qt\6.6.3\msvc2019_64."
}

$BuildDirName = switch ($Preset) {
    "windows-msvc-release" { "windows-msvc-release"; break }
    "windows-msvc-installer" { "windows-msvc-installer"; break }
    default { throw "Unknown Windows preset '$Preset'. Expected windows-msvc-release or windows-msvc-installer." }
}

$InstallDirName = switch ($Preset) {
    "windows-msvc-release" { "windows-msvc"; break }
    "windows-msvc-installer" { "windows-msvc-installer"; break }
    default { throw "Unknown Windows preset '$Preset'. Expected windows-msvc-release or windows-msvc-installer." }
}

$BuildDir = Join-Path $Root "build\$BuildDirName"

cmake -S (Join-Path $Root "src") --preset $Preset
cmake --build $BuildDir --config Release --target speedcrunch --parallel
cmake --install $BuildDir --config Release

if ($Package) {
    cmake --build $BuildDir --config Release --target package
}

Write-Host "Installed build output to: $Root\dist\$InstallDirName"
