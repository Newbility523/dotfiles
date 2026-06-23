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

if ($null -ne $current) {
    $currentBytes = [byte[]]$current

    if (Test-ByteArrayEqual $currentBytes $leftAltLeftWinSwap) {
        Write-Host "Left Alt <-> Left Windows swap is already registered."
        Write-Host "Restart Windows if the swap is not active yet."
        exit 0
    }

    if (-not $Force) {
        throw "Existing Scancode Map detected. Refusing to overwrite it. Re-run with -Force to back it up and replace it."
    }

    $backupName = "Scancode Map Backup $(Get-Date -Format yyyyMMddHHmmss)"
    New-ItemProperty -LiteralPath $regPath -Name $backupName -PropertyType Binary -Value $currentBytes -Force | Out-Null
    Write-Host "Backed up existing Scancode Map to registry value: $backupName"
}

New-ItemProperty -LiteralPath $regPath -Name $valueName -PropertyType Binary -Value $leftAltLeftWinSwap -Force | Out-Null

Write-Host "Registered Left Alt <-> Left Windows swap."
Write-Host "Restart Windows for the change to take effect."
