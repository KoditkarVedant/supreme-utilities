# Import helper functions
. .\helper.ps1

# Create backup
Write-ProfileLog -Message "Searching existing profile"

$basePath = Split-Path -Path $PROFILE -Parent
$dateString = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$backupRootPath = Join-Path -Path $basePath -ChildPath ".backup"
$backupTimestampPath = Join-Path -Path $backupRootPath -ChildPath $dateString

# Create backup directory structure
if (!(Test-Path $backupRootPath)) {
    New-Item -ItemType Directory -Path $backupRootPath -Force | Out-Null
    Write-ProfileLog -Message "Created backup root directory: $backupRootPath"
}

New-Item -ItemType Directory -Path $backupTimestampPath -Force | Out-Null
Write-ProfileLog -Message "Created backup timestamp directory: $backupTimestampPath"

if (Test-Path $PROFILE) {
    Write-ProfileLog -Message "Existing profile found: $PROFILE"
    Write-ProfileLog -Message "Creating backup of existing profile"

    $profileBackupPath = Join-Path -Path $backupTimestampPath -ChildPath "Microsoft.PowerShell_profile.ps1"
    Copy-Item -Path $PROFILE -Destination $profileBackupPath
    Write-ProfileLog -Message "Profile backed up: $profileBackupPath"

    Write-ProfileLog -Message "Removing existing profile"
    Remove-Item -Path $PROFILE
    Write-ProfileLog -Message "Profile removed"
}

# Backup existing helper-scripts folder if it exists
$existingScriptsFolder = Join-Path -Path $basePath -ChildPath "helper-scripts"
if (Test-Path $existingScriptsFolder) {
    Write-ProfileLog -Message "Existing helper-scripts folder found"
    Write-ProfileLog -Message "Creating backup of existing helper-scripts"
    
    $scriptsBackupPath = Join-Path -Path $backupTimestampPath -ChildPath "helper-scripts"
    Copy-Item -Path $existingScriptsFolder -Destination $scriptsBackupPath -Recurse -Force
    Write-ProfileLog -Message "Helper-scripts backed up: $scriptsBackupPath"
    
    Write-ProfileLog -Message "Removing existing helper-scripts folder"
    Remove-Item -Path $existingScriptsFolder -Recurse -Force
    Write-ProfileLog -Message "Helper-scripts folder removed"
}

# Handle local profile preservation
$localProfilePath = Join-Path -Path $basePath -ChildPath "Microsoft.PowerShell_profile.local.ps1"
$localProfileExists = Test-Path $localProfilePath

if ($localProfileExists) {
    Write-ProfileLog -Message "Preserving existing local profile: $localProfilePath"
} else {
    Write-ProfileLog -Message "No local profile found, will create template"
}

# Copy powershell profile components
Write-ProfileLog -Message "Copying new powershell profile components"

# Copy helper-scripts folder
$sourceScriptsFolder = Join-Path -Path $PSScriptRoot -ChildPath "helper-scripts"
$destinationScriptsFolder = Join-Path -Path $basePath -ChildPath "helper-scripts"
Copy-Item -Path $sourceScriptsFolder -Destination $destinationScriptsFolder -Recurse -Force
Write-ProfileLog -Message "Copied helper-scripts folder"

# Copy main profile (entry point)
$newProfileFilePath = Join-Path -Path $PSScriptRoot -ChildPath "Microsoft.PowerShell_profile.ps1"
Copy-Item -Path $newProfileFilePath -Destination $PROFILE
Write-ProfileLog -Message "Copied main profile"

# Copy base profile
$baseProfileSource = Join-Path -Path $PSScriptRoot -ChildPath "Microsoft.PowerShell_profile.base.ps1"
$baseProfileDestination = Join-Path -Path $basePath -ChildPath "Microsoft.PowerShell_profile.base.ps1"
Copy-Item -Path $baseProfileSource -Destination $baseProfileDestination
Write-ProfileLog -Message "Copied base profile"

# Create local profile from template if it doesn't exist
if (-not $localProfileExists) {
    $localTemplateSource = Join-Path -Path $PSScriptRoot -ChildPath "Microsoft.PowerShell_profile.local.template.ps1"
    Copy-Item -Path $localTemplateSource -Destination $localProfilePath
    Write-ProfileLog -Message "Created local profile template: $localProfilePath" -Level "Success"
    Write-Host "`nTo add personal customizations, edit: $localProfilePath" -ForegroundColor Cyan
} else {
    Write-ProfileLog -Message "Local profile preserved (no changes made)" -Level "Success"
}
