function Get-WebexTeamsRoom {
    param (
        [string]$teamID,
        [ValidateSet("Group", "Direct")]
        [string]$type,
        [int]$max

    )
    $body = @{
        teamID = $teamID
        type   = $type
        max    = $max
    }

    ($body.GetEnumerator() | ? { -not $_.Value }) | % { $body.Remove($_.Name) }

    $res = Invoke-RestMethod -Headers (Get-WebexTeamsCredential) `
        -ContentType "application/json" `
        -uri 'https://webexapis.com/v1/rooms' `
        -body $body
    return $res.items
}