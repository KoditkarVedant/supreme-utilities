# oh-my-posh --init --shell pwsh --config "~\AppData\Local\Programs\oh-my-posh\themes\rudolfs-light.omp.json" | Invoke-Expression
oh-my-posh --init --shell pwsh --config "~\AppData\Local\Programs\oh-my-posh\themes\tonybaloney.omp.json" | Invoke-Expression

Import-Module -Name Terminal-Icons

# oh-my-posh --init --shell pwsh --config "c:\github\prompt\ohmyposh.omp.json" | Invoke-Expression

function MoveToAWS {
    Set-Location "D:\Vedant\AWS"
}
