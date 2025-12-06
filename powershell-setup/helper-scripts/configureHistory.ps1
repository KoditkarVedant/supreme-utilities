#Requires -Version 5.1
#Requires -Module PSReadLine

using namespace System.Management.Automation

function configureHistory {
    [CmdletBinding()]
    param()
    
    try {
        # Ensure PSReadLine is available
        if (-not (Get-Module -Name PSReadLine)) {
            Import-Module PSReadLine -ErrorAction Stop
        }
        
        # Configure history settings with modern options
        $historyOptions = @{
            # Use a persistent history file
            # HistorySavePath = (Join-Path $HOME ".ps_history")
            
            # Increase history capacity
            MaximumHistoryCount = 10000
            
            # Modern history search and completion
            HistorySearchCursorMovesToEnd = $true
            PredictionSource = 'HistoryAndPlugin'
            #PredictionViewStyle = 'ListView'
            
            # Better editing experience  
            EditMode = 'Windows'
            ShowToolTips = $true
            
            # Colors for better visibility
            Colors = @{
                Command = 'Cyan'
                Parameter = 'DarkGray'
                String = 'Yellow'
                Comment = 'DarkGreen'
            }
        }
        
        # Apply settings with error handling
        try {
            #Set-PSReadLineOption -HistorySavePath $historyOptions.HistorySavePath

            Set-PSReadLineOption -MaximumHistoryCount $historyOptions.MaximumHistoryCount
            Set-PSReadLineOption -HistorySearchCursorMovesToEnd:$historyOptions.HistorySearchCursorMovesToEnd
            # Set-PSReadLineOption -PredictionSource $historyOptions.PredictionSource
            # Set-PSReadLineOption -EditMode $historyOptions.EditMode
            Set-PSReadLineOption -ShowToolTips:$historyOptions.ShowToolTips
            Set-PSReadLineOption -Colors $historyOptions.Colors
            Set-PSReadLineOption -HistoryNoDuplicates:$true
            Set-PSReadLineOption -HistorySaveStyle SaveIncrementally
        } catch {
            Write-Verbose "Could not set some PSReadLine options: $($_.Exception.Message)"
        }
        
        # Set up key bindings for enhanced navigation
        Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
        Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
        Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
        
        Write-Verbose "PSReadLine history configuration completed successfully"
        
    } catch {
        Write-Warning "Error configuring PSReadLine history: $($_.Exception.Message)"
    }
}