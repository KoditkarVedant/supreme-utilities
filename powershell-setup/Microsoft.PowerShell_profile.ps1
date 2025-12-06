#Requires -Version 5.1

# Profile initialization with error handling
try {
    # Get the profile directory
    $ProfileDir = Split-Path -Parent $PROFILE
    $HelperScriptsPath = Join-Path $ProfileDir "helper-scripts"
    
    # Verify helper-scripts directory exists
    if (-not (Test-Path $HelperScriptsPath)) {
        Write-Warning "Helper scripts directory not found: $HelperScriptsPath"
        return
    }
    
    # Import helper functions with error handling
    $HelperScripts = @(
        'loadOhMyPosh.ps1',
        'loadTerminalIcons.ps1', 
        'configureHistory.ps1'
    )
    
    foreach ($script in $HelperScripts) {
        $scriptPath = Join-Path $HelperScriptsPath $script
        if (Test-Path $scriptPath) {
            . $scriptPath
        } else {
            Write-Warning "Helper script not found: $scriptPath"
        }
    }
    
    # Initialize profile components with error handling
    if (Get-Command 'loadOhMyPosh' -ErrorAction SilentlyContinue) {
        loadOhMyPosh -Theme "tonybaloney"
    }
    
    if (Get-Command 'loadTerminalIcons' -ErrorAction SilentlyContinue) {
        loadTerminalIcons
    }
    
    if (Get-Command 'configureHistory' -ErrorAction SilentlyContinue) {
        configureHistory
    }
    
    # Initialize fnm if available
    if (Get-Command 'fnm' -ErrorAction SilentlyContinue) {
        fnm env --use-on-cd --shell powershell | Out-String | Invoke-Expression
    }
    
} catch {
    Write-Error "Error initializing PowerShell profile: $($_.Exception.Message)"
}