function Get-WebexTeamsRoom {
    param (
        
        [string]$teamID,
        [ValidateSet("group", "direct")]
        [string]$type,
        [ValidateRange(1,1000)]
        [int]$max = 1000

    )
    $body = @{
        teamID = $teamID
        type   = $type
        max    = $max
    }

    ($body.GetEnumerator() | Where-Object { -not $_.Value }) | ForEach-Object { $body.Remove($_.Name) }

    $res = Invoke-RestMethod -Headers (Get-WebexTeamsCredential) `
        -ContentType "application/json" `
        -uri 'https://webexapis.com/v1/rooms' `
        -body $body
    return $res.items
}