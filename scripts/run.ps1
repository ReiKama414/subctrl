# Permanent defines live in dart_defines.json — no need to type them each time.
param(
  [string]$Device = ""
)

$root = Split-Path -Parent $PSScriptRoot
Set-Location $root

$defines = Join-Path $root "dart_defines.json"
$args = @("run")
if (Test-Path $defines) {
  $args += @("--dart-define-from-file=dart_defines.json")
}
if ($Device) { $args += @("-d", $Device) }
flutter @args
