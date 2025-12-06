# Install OhMyPosh
if (!(CheckCommand -Name oh-my-posh)) {
    Log -Message "Installing Oh my posh"
    winget install JanDeDobbeleer.OhMyPosh
    Log -Message "Installed Oh my posh"
}
else {
    Log -Message "Skip: OhMyPosh already existss."
}

if (ModuleExists("Terminal-Icons")) {
    Log -Message "Skip: Terminal-Icons powershell module exists."
} 
else {
    Log -Message "Installing Terminal-Icons powershell module"
    Install-Module -Name Terminal-Icons -Repository PSGallery
    Log -Message "Installed Terminal-Icons powershell module"
}


Log -Message "Installing PSReadLine powershell module"
Install-Module PSReadLine -Force
Log -Message "Installed PSReadLine powershell module"
