function Get-WebexTeamsMemberships {
    param (
        $roomID,
        $personID,
        $email,
        $max
    )
    $body = @{
        roomID = $roomID
        personID = $personID
        personEmail = $Email
        max = $max
    }

    ($body.GetEnumerator() | ? { -not $_.Value }) | % { $body.Remove($_.Name) }

    $res = Invoke-RestMethod -Headers (Get-WebexTeamsCredential) `
        -ContentType "application/json" `
        -uri 'https://webexapis.com/v1/memberships' `
        -body $body
    return $res.items
}