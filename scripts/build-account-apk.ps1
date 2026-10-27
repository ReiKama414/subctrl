# Maintainer-only APK: login required + optional cloud (dart_defines.json, not for GitHub Releases).
param(
  [string]$OutDir = "build\account"
)

$root = Split-Path -Parent $PSScriptRoot
Set-Location $root

$defines = Join-Path $root "dart_defines.json"
if (-not (Test-Path $defines)) {
  Write-Error "Missing dart_defines.json — copy dart_defines.example.json and set APP_AUTH_MODE=account plus your keys/UID."
  exit 1
}

flutter build apk --release --dart-define-from-file=dart_defines.json
New-Item -ItemType Directory -Force -Path $OutDir | Out-Null
Copy-Item "build\app\outputs\flutter-apk\app-release.apk" (Join-Path $OutDir "subctrl-account-release.apk") -Force
Write-Host "Wrote $(Join-Path $OutDir 'subctrl-account-release.apk')"
