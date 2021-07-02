function Get-WebexTeamsMessage {
    param (
        [Parameter(ValueFromPipelineByPropertyName, mandatory = $true)]
        [Alias('id')]
        $roomId,
        [datetime]$before,
        [string]$beforeMessage,
        [ValidateRange(1, [Int32]::MaxValue)]
        [int32]$max = [Int32]::MaxValue,
        [Parameter()][string]$name = ""
    )
    $body = @{
        roomId        = $roomId
        before        = { 
            try { Get-Date $before -Format 'o' } 
            catch { $null }
        }
        beforeMessage = $beforeMessage
        max           = $max
    }
    
    ($body.GetEnumerator() | Where-Object { -not $_.Value }) | ForEach-Object { $body.Remove($_.Name) }
    return (Invoke-WebexRestMethod -Method GET -ResourceID ("/messages") -body $body)
}