function Get-WebexTeamsMemberships {
    param (
        $roomID,
        $personID,
        $email,
        $max
    )
    $body = @{
        roomID      = $roomID
        personID    = $personID
        personEmail = $Email
        max         = $max
    }

    ($body.GetEnumerator() | Where-Object { -not $_.Value }) | ForEach-Object { $body.Remove($_.Name) }
    try {
        $res = Invoke-RestMethod -Headers (Get-WebexTeamsCredential) `
            -ContentType "application/json" `
            -uri 'https://webexapis.com/v1/memberships' `
            -body $body
        return $res.items
    }
    catch {
        Write-Error ($_.ErrorDetails.Message | ConvertFrom-Json).message
    }
}