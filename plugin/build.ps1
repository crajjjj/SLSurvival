# Builds SLSurvival.dll into SKSE\Plugins.
#
#   .\plugin\build.ps1           # release
#   .\plugin\build.ps1 -Debug    # debug build (MTd, no optimisation)
#
# Needs xmake 3.0+, VS 2022 and the CommonLibSSE-NG submodule
# (git submodule update --init --recursive). Override xmake with XMAKE_EXE.
param([switch]$Debug)

$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent

# One version for the mod and the DLL: fomod\info.xml. SL Survival versions are X.YYY;
# a packed SKSE plugin version has 8 bits for the minor number, so 0.800 -> 0.8.0 and
# 0.815 -> 0.8.15.
[xml]$info = Get-Content (Join-Path $root 'fomod\info.xml') -Raw
$modVersion = $info.fomod.Version.Trim()
if ($modVersion -notmatch '^(\d+)\.(\d{3})$') { throw "fomod\info.xml <Version> is '$modVersion' - expected X.YYY" }
$minor = [int]$Matches[2]
$version = '{0}.{1}.{2}' -f $Matches[1], [math]::Floor($minor / 100), ($minor % 100)

$xmake = $env:XMAKE_EXE
if (-not $xmake) { $xmake = 'xmake' }

# The commonlib plugin rule installs into <XSE_TES5_MODS_PATH>\SLSurvival after every
# build. xmake.lua re-points that into plugin\build; unsetting the variable here as well
# keeps a stray folder out of the live Mod Organizer mods directory.
$env:XSE_TES5_MODS_PATH = $null

Push-Location $PSScriptRoot
try {
    $mode = if ($Debug) { 'debug' } else { 'release' }
    & $xmake f -y -m $mode "--sls_version=$version"
    if ($LASTEXITCODE) { throw "xmake config failed ($LASTEXITCODE)" }
    & $xmake build -y SLSurvival
    if ($LASTEXITCODE) { throw "xmake build failed ($LASTEXITCODE)" }
} finally {
    Pop-Location
}

$dll = Join-Path $root 'SKSE\Plugins\SLSurvival.dll'
$have = (Get-Item $dll).VersionInfo.FileVersion
if ($have -ne "$version.0") { throw "$dll is version '$have', expected $version.0" }
Write-Host "SLSurvival.dll $version (SL Survival $modVersion) -> SKSE\Plugins" -ForegroundColor Green
