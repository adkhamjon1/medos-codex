$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $PSScriptRoot
$puro = Join-Path $env:LOCALAPPDATA "Microsoft\WinGet\Packages\pingbird.Puro_Microsoft.Winget.Source_8wekyb3d8bbwe\puro.exe"
$sdk = Join-Path $env:LOCALAPPDATA "Android\Sdk"
$jdk = "C:\Program Files\Eclipse Adoptium\jdk-17.0.19.10-hotspot"
$git = "C:\Program Files\Git\cmd"

$env:JAVA_HOME = $jdk
$env:ANDROID_HOME = $sdk
$env:ANDROID_SDK_ROOT = $sdk
$env:Path = "$git;$jdk\bin;$sdk\cmdline-tools\latest\bin;$sdk\platform-tools;$env:Path"

Push-Location $root
try {
    & $puro -e stable flutter build apk --release

    New-Item -ItemType Directory -Force -Path "builds" | Out-Null
    Copy-Item -Force "build\app\outputs\flutter-apk\app-release.apk" "builds\medos.apk"

    Get-Item "builds\medos.apk" | Select-Object FullName, Length, LastWriteTime
}
finally {
    Pop-Location
}
