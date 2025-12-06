# PowerShell Local Profile - Personal Customizations
# This file is preserved during setup updates and contains your personal settings

# Example local customizations (uncomment and modify as needed):

# Custom aliases
# Set-Alias -Name "ll" -Value "Get-ChildItem"
# Set-Alias -Name "grep" -Value "Select-String"

# Custom functions
# function Get-GitStatus { git status --porcelain }
# Set-Alias -Name "gs" -Value "Get-GitStatus"

# Environment variables
# $env:EDITOR = "code"
# $env:BROWSER = "chrome"

# Custom PowerShell options
# $PSDefaultParameterValues['Out-Default:OutVariable'] = '__'

# Custom prompt (if you don't want Oh My Posh)
# function prompt {
#     $currentPath = (Get-Location).Path.Replace($HOME, "~")
#     "$currentPath> "
# }

# Module imports for personal tools
# Import-Module MyPersonalModule -ErrorAction SilentlyContinue

# Custom variables
# $MyScriptsPath = Join-Path $HOME "Scripts"

Write-Host "Local profile customizations loaded" -ForegroundColor Green