function  Set-WebexTeamsCredential {
    param (
        [Parameter(Mandatory=$true)]
        [string]$token
    )
    try {
        $configpath = Resolve-WebexTeamsConfigPath
        if ($null -eq $configpath) {throw "Unable to resolve config path"}
    }
    catch {exit}
    $configContainer = Split-Path $configpath
    if((Test-Path $configContainer) -eq $false) {
        New-Item -Path $configContainer -Name (Split-Path $configContainer -Leaf) -ItemType Directory
    }
    $config = @{
        "Authorization" = "Bearer $token"
    }
    [void]($config | Export-Clixml -Path $configpath)
}