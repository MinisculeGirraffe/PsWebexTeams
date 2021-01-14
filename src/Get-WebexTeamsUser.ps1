function Get-WebexTeamsUser {
    param (
        $Email,
        $DisplayName

    )
    $body = @{
        email = $Email
    }
    $res = Invoke-RestMethod -Headers (Get-WebexTeamsCredential) `
        -ContentType "application/json" `
        -uri 'https://webexapis.com/v1/people' `
        -body $body
    return $res.items

}