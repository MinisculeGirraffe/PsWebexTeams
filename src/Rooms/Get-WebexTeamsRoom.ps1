function Get-WebexTeamsRoom {
    param (
        
        [string]$teamID,
        [ValidateSet("group", "direct")]
        [string]$type,
        [ValidateRange(1, 1000)]
        [int]$max = 1000,
        [ValidateSet("id", 'lastactivity', "created")]
        [string]$sortBy = 'lastactivity'

    )
    $body = @{
        teamID = $teamID
        type   = $type
        max    = $max
        soryBy = $sortBy
    }

    ($body.GetEnumerator() | Where-Object { -not $_.Value }) | ForEach-Object { $body.Remove($_.Name) }
    try {
        $res = Invoke-RestMethod -Headers (Get-WebexTeamsCredential) `
            -ContentType "application/json" `
            -uri 'https://webexapis.com/v1/rooms' `
            -body $body
        return $res.items
    }
    catch {
        Write-Error ($_.ErrorDetails.Message | ConvertFrom-Json).message
    }
}