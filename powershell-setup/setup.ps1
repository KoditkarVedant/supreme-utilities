[CmdletBinding()]
param (
    [ValidateNotNullOrEmpty()]
    [ValidateSet("All", "ReplaceProfile", "Setup")]
    [string]$Run
)

function Log {
    [CmdletBinding()]
    param (
        [ValidateNotNullOrEmpty()]
        [string]$Message
    )

    Write-Host -NoNewLine "[$(Get-Date -Format "yyyy-MM-dd HH:mm:ss")] "
    Write-Host $message

}

function CheckCommand {
    [CmdletBinding()]
    param (
        [ValidateNotNullOrEmpty()]
        [string]$Name
    )

    return [bool](Get-Command -Name $Name -ErrorAction SilentlyContinue)
}

Log -Message "Powershell Scrip Root: $PSScriptRoot"

if ($Run -eq "All") {
    & "$PSScriptRoot\install.ps1"
    & "$PSScriptRoot\replace-profile.ps1"
}
elseif ($Run -eq "ReplaceProfile") {
    & "$PSScriptRoot\replace-profile.ps1"
}
elseif ($Run -eq "Setup") {
    & "$PSScriptRoot\install.ps1"
}

Write-Host "`nPress any key to continue...";
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown");
