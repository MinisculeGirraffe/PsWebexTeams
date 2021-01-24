function New-WebexTeamsAccessToken {
    param (
        $clientID,
        $clientSecret,
        $refreshToken
    )
    $uri = 'https://webexapis.com/v1/access_token'

    $body = @{
        grant_type    = "refresh_token"
        client_secret = $clientSecret
        client_id     = $clientID
        refresh_token = $refreshToken
    }
    try {
        $res = Invoke-RestMethod -Uri $uri `
            -Method Post `
            -Body $body `
            -ContentType "application/x-www-form-urlencoded" 

    }
    catch {
        Write-Error ($_.ErrorDetails.Message | ConvertFrom-Json).message
    }

    $res | Add-Member -MemberType NoteProperty -Name issued_at -Value ([DateTimeOffset]::Now.ToUnixTimeSeconds())

    return $res
}