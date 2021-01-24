function New-WebexTeamsRefreshToken {
    param (
        $accessCode,
        $clientID,
        $clientSecret,
        $redirectURI
    )
    
    $body = @{
        grant_type    = "authorization_code"
        code          = $accessCode
        client_id     = $clientID
        client_secret = $clientSecret
        redirect_uri  = $redirectURI
    }
    try {
        $res = Invoke-RestMethod -Method Post `
            -Uri 'https://webexapis.com/v1/access_token' `
            -ContentType "application/x-www-form-urlencoded" `
            -Body $body
        $res | Add-Member -MemberType NoteProperty -Name issued_at -Value ([DateTimeOffset]::Now.ToUnixTimeSeconds())
        $res | Add-Member -MemberType NoteProperty -Name client_id -Value $clientID
        $res | Add-Member -MemberType NoteProperty -Name client_secret -Value $clientSecret
        $res | Add-Member -MemberType NoteProperty -Name redirect_uri -Value $redirectURI
        
    }
    catch {
        Write-Error ($_.ErrorDetails.Message | ConvertFrom-Json).message
    }
   return $res
}  
