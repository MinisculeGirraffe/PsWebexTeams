function Get-WebexTeamsRoom {
    param (
        
        [string]$teamID,
        [ValidateSet("group", "direct")]
        [string]$type,
        [ValidateRange(1, 1000)]
        [int]$max = 1000,
        [ValidateSet("id", 'lastactivity', "created")]
        [string]$sortBy = 'lastactivity',
        [Parameter()][string]$name = ""
    )
    $body = @{
        teamID = $teamID
        type   = $type
        max    = $max
        soryBy = $sortBy
    }
    ($body.GetEnumerator() | Where-Object { -not $_.Value }) | ForEach-Object { $body.Remove($_.Name) }
    return (Invoke-WebexRestMethod -Method GET -ResourceID ('/rooms') -body $body)
}