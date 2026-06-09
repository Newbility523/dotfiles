#Requires -Version 5.1

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$dotfilesDir = if ($env:DOTFILES_DIR) { $env:DOTFILES_DIR } else { $PSScriptRoot }
$hotkeyScript = Join-Path $dotfilesDir "autohotkey\mac-style-alt-copy-paste.ahk"

if (-not (Test-Path -LiteralPath $hotkeyScript)) {
    throw "Missing AutoHotkey script: $hotkeyScript"
}

$candidates = @()
if ($env:LOCALAPPDATA) {
    $candidates += Join-Path $env:LOCALAPPDATA "Programs\AutoHotkey\v2\AutoHotkey64.exe"
    $candidates += Join-Path $env:LOCALAPPDATA "Programs\AutoHotkey\AutoHotkey64.exe"
}
if ($env:ProgramFiles) {
    $candidates += Join-Path $env:ProgramFiles "AutoHotkey\v2\AutoHotkey64.exe"
    $candidates += Join-Path $env:ProgramFiles "AutoHotkey\AutoHotkey64.exe"
}
if (${env:ProgramFiles(x86)}) {
    $candidates += Join-Path ${env:ProgramFiles(x86)} "AutoHotkey\v2\AutoHotkey64.exe"
    $candidates += Join-Path ${env:ProgramFiles(x86)} "AutoHotkey\AutoHotkey64.exe"
}

$autoHotkey = $candidates | Where-Object { Test-Path -LiteralPath $_ } | Select-Object -First 1
if (-not $autoHotkey) {
    $autoHotkey = Get-Command AutoHotkey64.exe,AutoHotkey.exe -ErrorAction SilentlyContinue |
        Select-Object -ExpandProperty Source -First 1
}
if (-not $autoHotkey) {
    throw "AutoHotkey v2 was not found. Install AutoHotkey, then run this script again."
}

$startupDir = [Environment]::GetFolderPath([Environment+SpecialFolder]::Startup)
$shortcutPath = Join-Path $startupDir "Mac Style Alt Copy Paste.lnk"

$shell = New-Object -ComObject WScript.Shell
$shortcut = $shell.CreateShortcut($shortcutPath)
$shortcut.TargetPath = $autoHotkey
$shortcut.Arguments = "`"$hotkeyScript`""
$shortcut.WorkingDirectory = Split-Path -Parent $hotkeyScript
$shortcut.Save()

Write-Host "Linked: $shortcutPath -> $hotkeyScript"
