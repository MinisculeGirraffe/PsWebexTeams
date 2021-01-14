function Get-WebexTeamsUser {
    param (
        $Email,
        $DisplayName,
        $Token
    )
    $body = @{
        email = $Email
    }
    $res = Invoke-RestMethod -Headers @{"Authorization" = "Bearer $Token" }`
        -ContentType "application/json" `
        -uri 'https://webexapis.com/v1/people' `
        -body $body
    return $res.items

}