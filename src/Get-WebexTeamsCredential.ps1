function Get-WebexTeamsCredential {
    try {
        $configpath = Resolve-WebexTeamsConfigPath
        if ($null -eq $configpath) {throw "Unable to resolve config path"}
    }
    catch {exit}

    return Import-Clixml $configpath
    
}