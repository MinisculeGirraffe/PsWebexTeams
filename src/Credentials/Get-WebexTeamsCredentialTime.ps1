function Get-WebexTeamsCredentialTime {
    param (
        $refreshInfo
    )
    try {
        $configpath = Resolve-WebexTeamsConfigPath
        if ($null -eq $configpath) { throw "Unable to resolve config path" }
    }
    catch { exit }
    
    $config = Import-Clixml $configpath
    $issueTime = [timezone]::CurrentTimeZone.ToLocalTime(([datetime]'1/1/1970').AddSeconds($config.refreshinfo.issued_at))
    $refreshExpires = $issueTime.AddSeconds($config.refreshinfo.refresh_token_expires_in)

    return New-TimeSpan -Start (Get-Date) -End ($refreshExpires)
}