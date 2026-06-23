#Requires -Version 5.1

[CmdletBinding()]
param(
    [switch]$Force
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Test-Administrator {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = [Security.Principal.WindowsPrincipal]$identity
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Test-ByteArrayEqual {
    param(
        [byte[]]$Left,
        [byte[]]$Right
    )

    if ($null -eq $Left -or $null -eq $Right) {
        return $false
    }
    if ($Left.Length -ne $Right.Length) {
        return $false
    }

    for ($i = 0; $i -lt $Left.Length; $i++) {
        if ($Left[$i] -ne $Right[$i]) {
            return $false
        }
    }

    return $true
}

if (-not (Test-Administrator)) {
    throw "Run this script from an elevated PowerShell session (Run as Administrator)."
}

$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Keyboard Layout"
$valueName = "Scancode Map"
$leftAltLeftWinSwap = [byte[]]@(
    0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00,
    0x03, 0x00, 0x00, 0x00,
    0x38, 0x00, 0x5B, 0xE0,
    0x5B, 0xE0, 0x38, 0x00,
    0x00, 0x00, 0x00, 0x00
)

$key = Get-Item -LiteralPath $regPath
$current = $key.GetValue($valueName, $null)

if ($null -eq $current) {
    Write-Host "No Scancode Map is registered."
    exit 0
}

$currentBytes = [byte[]]$current
if (-not (Test-ByteArrayEqual $currentBytes $leftAltLeftWinSwap) -and -not $Force) {
    throw "Existing Scancode Map does not match this Left Alt <-> Left Windows swap. Re-run with -Force to remove it anyway."
}

Remove-ItemProperty -LiteralPath $regPath -Name $valueName

Write-Host "Removed Scancode Map."
Write-Host "Restart Windows for the change to take effect."
