function Get-WebexTeamsCredential {
    param(
        [Parameter(Mandatory = $true)][string]$name,
        [switch]$Renew
    )
    try {
        $configpath = ((Resolve-WebexTeamsConfigPath) -replace ".xml") + "-$name.xml"
        if ($null -eq $configpath) { throw "Unable to resolve config path" }
    }
    catch { exit }
    
    $config = Import-Clixml $configpath
    if ($config.refreshInfo) {
        $issueTime = [timezone]::CurrentTimeZone.ToLocalTime(([datetime]'1/1/1970').AddSeconds($config.refreshinfo.issued_at))
        $accessExpires = $issueTime.AddSeconds($config.refreshinfo.expires_in)
        $accessTimeLeft = New-TimeSpan -Start (Get-Date) -End $accessExpires
        if (($accessTimeLeft.TotalMinutes -le 1) -or ($renew)) { 
            $token = New-WebexTeamsAccessToken -clientID $config.refreshinfo.client_id `
                -clientSecret $config.refreshinfo.client_secret `
                -refreshToken $config.refreshinfo.refresh_token
            Set-WebexTeamsCredential -token $token.access_token -refreshinfo $token
            $config = Import-Clixml $configpath
        }
    }
    $key = Import-Clixml -Path $configpath
    $config = @{}
    $config.token = @{"Authorization" = "Bearer " + (([Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($key))))}
    return $config.token
}