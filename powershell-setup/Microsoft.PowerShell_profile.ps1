#Requires -Version 5.1
# PowerShell Profile - Main Entry Point
# This profile imports both base configuration and local customizations

try {
    $ProfileDir = Split-Path -Parent $PROFILE
    
    # Import base configuration (managed by setup script)
    $BaseProfile = Join-Path $ProfileDir "Microsoft.PowerShell_profile.base.ps1"
    if (Test-Path $BaseProfile) {
        . $BaseProfile
        Write-Verbose "Base profile loaded: $BaseProfile"
    } else {
        Write-Warning "Base profile not found: $BaseProfile"
    }
    
    # Import local customizations (preserved during setup)
    $LocalProfile = Join-Path $ProfileDir "Microsoft.PowerShell_profile.local.ps1"
    if (Test-Path $LocalProfile) {
        . $LocalProfile
        Write-Verbose "Local profile loaded: $LocalProfile"
    } else {
        Write-Host "No local profile found. Create '$LocalProfile' for personal customizations." -ForegroundColor Yellow
    }
    
} catch {
    Write-Error "Error loading PowerShell profile: $($_.Exception.Message)"
}