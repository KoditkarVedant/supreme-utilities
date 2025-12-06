#Requires -Version 5.1

using namespace System.Management.Automation

function loadTerminalIcons {
    [CmdletBinding()]
    param()
    
    try {
        # Check if module is available
        if (-not (Get-Module -ListAvailable -Name 'Terminal-Icons')) {
            Write-Verbose "Terminal-Icons module not found, installing..."
            
            # Install with modern parameters and error handling
            $installParams = @{
                Name = 'Terminal-Icons'
                Repository = 'PSGallery'
                Scope = 'CurrentUser'
                Force = $true
                AllowClobber = $true
                ErrorAction = 'Stop'
            }
            
            Install-Module @installParams
            Write-Host "✓ Terminal-Icons module installed successfully" -ForegroundColor Green
        }
        
        # Import module if not already loaded
        if (-not (Get-Module -Name 'Terminal-Icons')) {
            Import-Module -Name 'Terminal-Icons' -ErrorAction Stop
            Write-Verbose "Terminal-Icons module imported successfully"
        }
        
    } catch {
        Write-Warning "Failed to load Terminal-Icons: $($_.Exception.Message)"
    }
}