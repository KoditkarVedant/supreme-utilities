# Create backup
Log -Message "Searching existing profile"

if (Test-Path $PROFILE) {
    Log -Message "Existing profile found: $PROFILE"
    Log -Message "Creating backup of existing profile"

    $basePath = Split-Path -Path $PROFILE -Parent
    $fileName = Split-Path -Path $PROFILE -LeafBase
    $dateString = Get-Date -Format "MM_dd_yyyy_HH_mm_ss"
    $backupFileName = $fileName + "_" + $dateString + ".ps1"
    $destination = Join-Path -Path $basePath -ChildPath $backupFileName

    Copy-Item -Path $PROFILE -Destination $destination
    Log -Message "Profile backed up: $destination"

    Log -Message "Removing existing profile"
    Remove-Item -Path $PROFILE
    Log -Message "Profile removed"
}

# Copy powershell pofile to destination
Log -Message "Copying new powershell profile"
$newProfileFilePath = Join-Path -Path $PSScriptRoot -ChildPath Microsoft.PowerShell_profile.ps1
Copy-Item -Path $newProfileFilePath -Destination $PROFILE
Log -Message "Copied new powershell profile"
