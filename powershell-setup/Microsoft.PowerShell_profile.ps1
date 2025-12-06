oh-my-posh --init --shell pwsh --config "~\AppData\Local\Programs\oh-my-posh\themes\tonybaloney.omp.json" | Invoke-Expression

Import-Module -Name Terminal-Icons

Set-PSReadLineOption -PredictionSource History -EditMode Windows -PredictionViewStyle ListView
