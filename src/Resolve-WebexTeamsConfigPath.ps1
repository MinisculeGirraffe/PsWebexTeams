function Resolve-WebexTeamsConfigPath {
    if ([System.Environment]::OSVersion.Platform -eq "Win32NT") {
        return "$env:LOCALAPPDATA\PSWebexTeams\PSWebexTeamsConfig.xml"

    }
    elseif ([System.Environment]::OSVersion.Platform -eq "Unix" -eq $true) {
        return "$env:HOMHE/.config/powershell/PSWebexTeamsConfig.xml"
    }
    else {
        return $null
    }
    
}