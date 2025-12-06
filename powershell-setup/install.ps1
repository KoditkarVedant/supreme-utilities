# Install OhMyPosh
if (!(CheckCommand -Name oh-my-posh)) {
    Log -Message "Installing Oh my posh"
    winget install JanDeDobbeleer.OhMyPosh
    Log -Message "Installed Oh my posh"
}

Log -Message "Installing Terminal-Icons powershell module"
Install-Module -Name Terminal-Icons -Repository PSGallery
