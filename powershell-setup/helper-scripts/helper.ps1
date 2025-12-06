#Requires -Version 5.1

using namespace System.Management.Automation

function Write-ProfileLog {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [string]$Message,
        
        [Parameter()]
        [ValidateSet('Info', 'Warning', 'Error', 'Success')]
        [string]$Level = 'Info'
    )
    
    $colors = @{
        'Info' = 'Cyan'
        'Warning' = 'Yellow'  
        'Error' = 'Red'
        'Success' = 'Green'
    }
    
    $timestamp = Get-Date -Format 'HH:mm:ss'
    Write-Host "[$timestamp] $Message" -ForegroundColor $colors[$Level]
}

function Test-CommandExists {
    [CmdletBinding()]
    [OutputType([bool])]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [string]$Name
    )
    
    return [bool](Get-Command -Name $Name -ErrorAction SilentlyContinue)
}

function Test-ModuleAvailable {
    [CmdletBinding()]
    [OutputType([bool])]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [string]$ModuleName
    )
    
    return [bool](Get-Module -ListAvailable -Name $ModuleName -ErrorAction SilentlyContinue)
}



function Install-Winget-Package {
    param (
        [string]$PackageName,
        [string]$InstallerCommand,
        [string]$CheckCommand,
        [string]$Source = "winget"
    )

    if (!(Test-CommandExists -Name $CheckCommand)) {
        Write-ProfileLog -Message "Installing $PackageName"
        winget install $InstallerCommand --source $Source
        Write-ProfileLog -Message "Installed $PackageName"
    }
    else {
        Write-ProfileLog -Message "Skip: $PackageName already exists."
    }
}

function Install-PS-Module {
    param (
        [string]$ModuleName,
        [string]$Repository = "PSGallery"
    )

    if (Test-ModuleAvailable -ModuleName $ModuleName) {
        Write-ProfileLog -Message "Skip: $ModuleName powershell module exists."
    } 
    else {
        Write-ProfileLog -Message "Installing $ModuleName powershell module"
        Install-Module -Name $ModuleName -Repository $Repository -Scope CurrentUser
        Write-ProfileLog -Message "Installed $ModuleName powershell module"
    }
}
