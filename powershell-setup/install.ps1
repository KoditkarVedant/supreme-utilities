. .\helper.ps1

Install-Winget-Package `
    -PackageName "Oh My Posh" `
    -InstallerCommand "JanDeDobbeleer.OhMyPosh" `
    -CheckCommand "oh-my-posh"

Install-PS-Module -ModuleName "Terminal-Icons"
Install-PS-Module -ModuleName "PSReadLine"

Install-Winget-Package `
    -PackageName "fnm (Fast Node Manager)" `
    -InstallerCommand "Schniz.fnm" `
    -CheckCommand "fnm"