function Get-WebexTeamsMemberships {
    param (
        $roomID,
        $personID,
        $email,
        $max,
        [Parameter()][string]$name = ""
    )
    $body = @{
        roomID      = $roomID
        personID    = $personID
        personEmail = $Email
        max         = $max
    }

    ($body.GetEnumerator() | Where-Object { -not $_.Value }) | ForEach-Object { $body.Remove($_.Name) }
    return (Invoke-WebexRestMethod -ResourceID ('/memberships') -Method GET)
}