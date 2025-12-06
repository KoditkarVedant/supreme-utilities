#Requires -Version 5.1

using namespace System.Management.Automation

function loadOhMyPosh {
    [CmdletBinding()]
    param (
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]$Theme = "paradox"
    )
    
    try {
        # Check if oh-my-posh is available
        if (-not (Get-Command 'oh-my-posh' -ErrorAction SilentlyContinue)) {
            Write-Warning "oh-my-posh command not found. Please install oh-my-posh first."
            return
        }
        
        # Modern path resolution
        $ohMyPoshPath = if ($IsWindows -or $PSVersionTable.PSVersion.Major -lt 6) {
            "$env:LOCALAPPDATA\Programs\oh-my-posh\themes\$Theme.omp.json"
        } else {
            "~/.cache/oh-my-posh/themes/$Theme.omp.json"
        }
        
        # Verify theme file exists
        if (-not (Test-Path $ohMyPoshPath)) {
            Write-Warning "Theme file not found: $ohMyPoshPath. Using default theme."
            $ohMyPoshPath = "$env:LOCALAPPDATA\Programs\oh-my-posh\themes\paradox.omp.json"
        }
        
        # Initialize oh-my-posh with error handling
        $initScript = oh-my-posh --init --shell pwsh --config $ohMyPoshPath 2>$null
        if ($initScript) {
            Invoke-Expression $initScript
            Write-Verbose "Oh My Posh initialized with theme: $Theme"
        } else {
            Write-Warning "Failed to initialize Oh My Posh"
        }
        
    } catch {
        Write-Warning "Error loading Oh My Posh: $($_.Exception.Message)"
    }
}