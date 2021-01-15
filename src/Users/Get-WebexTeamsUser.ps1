function Get-WebexTeamsUser {
    param (
        $Email,
        $DisplayName,
        [Parameter(ValueFromPipelineByPropertyName)]
        $id,
        [Parameter(ValueFromPipelineByPropertyName)]
        $orgId,
        [Parameter(ValueFromPipelineByPropertyName)]
        $locationID,
        $max

    )
    $body = @{
        id         = $id
        email      = $Email
        orgID      = $orgId
        locationID = $locationID
        max        = $max
    }
    ($body.GetEnumerator() | ? { -not $_.Value }) | % { $body.Remove($_.Name) }
    $res = Invoke-RestMethod -Headers (Get-WebexTeamsCredential) `
        -ContentType "application/json" `
        -uri 'https://webexapis.com/v1/people' `
        -body $body
    return $res.items

}