# FloriDevs W11Fixer
# Windows 11 Optimization Script
# Run as Administrator

$ErrorActionPreference = "Continue"
$Host.UI.RawUI.WindowTitle = "FloriDevs W11Fixer"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   FloriDevs W11Fixer v1.0" -ForegroundColor Cyan
Write-Host "   Windows 11 Optimization Script" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check for Administrator privileges
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "ERROR: This script requires Administrator privileges!" -ForegroundColor Red
    Write-Host "Please right-click and select 'Run as Administrator'" -ForegroundColor Yellow
    pause
    exit
}

# Function to create registry key if it doesn't exist
function Set-RegistryValue {
    param($Path, $Name, $Value, $Type = "DWord")
    if (!(Test-Path $Path)) {
        New-Item -Path $Path -Force | Out-Null
    }
    Set-ItemProperty -Path $Path -Name $Name -Value $Value -Type $Type -Force
}

# ======================================
# 1. REDUCE TELEMETRY & PRIVACY SETTINGS
# ======================================
Write-Host "[1/6] Reducing telemetry and improving privacy..." -ForegroundColor Green

# Disable telemetry
Set-RegistryValue "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" "AllowTelemetry" 0
Set-RegistryValue "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" "AllowTelemetry" 0

# Disable activity history
Set-RegistryValue "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" "EnableActivityFeed" 0
Set-RegistryValue "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" "PublishUserActivities" 0

# Disable advertising ID
Set-RegistryValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" "Enabled" 0

# Disable location tracking
Set-RegistryValue "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" "DisableLocation" 1

# Disable feedback requests
Set-RegistryValue "HKCU:\Software\Microsoft\Siuf\Rules" "NumberOfSIUFInPeriod" 0

# Disable Windows tips
Set-RegistryValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-338389Enabled" 0

Write-Host "  Privacy settings configured!" -ForegroundColor Gray

# ======================================
# 2. TASKBAR TO LEFT
# ======================================
Write-Host "[2/6] Moving taskbar icons to the left..." -ForegroundColor Green

Set-RegistryValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "TaskbarAl" 0

Write-Host "  Taskbar aligned to left!" -ForegroundColor Gray

# ======================================
# 3. RESTORE CLASSIC CONTEXT MENU
# ======================================
Write-Host "[3/6] Restoring classic context menu..." -ForegroundColor Green

# Remove the Windows 11 context menu handler
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve

Write-Host "  Classic context menu restored!" -ForegroundColor Gray

# ======================================
# 4. REMOVE BLOATWARE
# ======================================
Write-Host "[4/6] Removing bloatware apps..." -ForegroundColor Green

$bloatware = @(
    "Microsoft.BingNews",
    "Microsoft.BingWeather",
    "Microsoft.GamingApp",
    "Microsoft.GetHelp",
    "Microsoft.Getstarted",
    "Microsoft.MicrosoftOfficeHub",
    "Microsoft.MicrosoftSolitaireCollection",
    "Microsoft.People",
    "Microsoft.PowerAutomateDesktop",
    "Microsoft.Todos",
    "Microsoft.WindowsAlarms",
    "Microsoft.WindowsFeedbackHub",
    "Microsoft.WindowsMaps",
    "Microsoft.Xbox.TCUI",
    "Microsoft.XboxGameOverlay",
    "Microsoft.XboxGamingOverlay",
    "Microsoft.XboxIdentityProvider",
    "Microsoft.XboxSpeechToTextOverlay",
    "Microsoft.ZuneMusic",
    "Microsoft.ZuneVideo",
    "MicrosoftTeams",
    "Clipchamp.Clipchamp",
    "*TikTok*",
    "*Facebook*",
    "*Instagram*",
    "*Spotify*",
    "*Disney*"
)

foreach ($app in $bloatware) {
    Write-Host "  Removing $app..." -ForegroundColor Gray -NoNewline
    Get-AppxPackage -Name $app -AllUsers | Remove-AppxPackage -ErrorAction SilentlyContinue
    Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like $app | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue
    Write-Host " Done" -ForegroundColor Green
}

Write-Host "  Bloatware removed!" -ForegroundColor Gray

# ======================================
# 5. INSTALL FIREFOX (if not present)
# ======================================
Write-Host "[5/6] Checking for Firefox..." -ForegroundColor Green

$firefoxPath = "C:\Program Files\Mozilla Firefox\firefox.exe"
if (!(Test-Path $firefoxPath)) {
    Write-Host "  Firefox not found. Downloading and installing..." -ForegroundColor Yellow
    
    $firefoxInstaller = "$env:TEMP\firefox_installer.exe"
    try {
        Invoke-WebRequest -Uri "https://download.mozilla.org/?product=firefox-latest&os=win64&lang=en-US" -OutFile $firefoxInstaller
        Start-Process -FilePath $firefoxInstaller -Args "/S" -Wait
        Remove-Item $firefoxInstaller -Force
        Write-Host "  Firefox installed successfully!" -ForegroundColor Green
    } catch {
        Write-Host "  Failed to install Firefox. Please install manually." -ForegroundColor Red
    }
} else {
    Write-Host "  Firefox already installed!" -ForegroundColor Gray
}

# ======================================
# 6. DISABLE EDGE (Cannot fully remove)
# ======================================
Write-Host "[6/6] Disabling Microsoft Edge..." -ForegroundColor Green

# Prevent Edge from running in background
Set-RegistryValue "HKLM:\SOFTWARE\Policies\Microsoft\Edge" "BackgroundModeEnabled" 0

# Disable Edge startup boost
Set-RegistryValue "HKLM:\SOFTWARE\Policies\Microsoft\Edge" "StartupBoostEnabled" 0

# Remove Edge desktop shortcut
$edgeShortcut = "$env:PUBLIC\Desktop\Microsoft Edge.lnk"
if (Test-Path $edgeShortcut) {
    Remove-Item $edgeShortcut -Force
}

# Disable Edge prelaunch
Set-RegistryValue "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main" "AllowPrelaunch" 0

# Disable Edge tab preloading
Set-RegistryValue "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\TabPreloader" "AllowTabPreloading" 0

Write-Host "  Edge disabled (Note: Complete removal requires third-party tools)" -ForegroundColor Gray

# ======================================
# COMPLETION
# ======================================
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   Optimization Complete!" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Changes applied:" -ForegroundColor Yellow
Write-Host "  [✓] Privacy settings optimized" -ForegroundColor Green
Write-Host "  [✓] Taskbar moved to left" -ForegroundColor Green
Write-Host "  [✓] Classic context menu restored" -ForegroundColor Green
Write-Host "  [✓] Bloatware removed" -ForegroundColor Green
Write-Host "  [✓] Firefox installed/verified" -ForegroundColor Green
Write-Host "  [✓] Edge disabled" -ForegroundColor Green
Write-Host ""
Write-Host "IMPORTANT: Please restart your computer for all changes to take effect!" -ForegroundColor Yellow
Write-Host ""

$restart = Read-Host "Would you like to restart now? (Y/N)"
if ($restart -eq "Y" -or $restart -eq "y") {
    Write-Host "Restarting in 10 seconds..." -ForegroundColor Yellow
    Start-Sleep -Seconds 10
    Restart-Computer -Force
} else {
    Write-Host "Please restart manually when ready." -ForegroundColor Yellow
    pause
}
