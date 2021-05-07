function  Set-WebexTeamsCredential {
    param (
        [Parameter(Mandatory = $true)]
        [string]$token,
        $refreshinfo
    )
    #Check that we can determine the path we should store the config
    try {
        $configpath = Resolve-WebexTeamsConfigPath
        if ($null -eq $configpath) { throw "Unable to resolve config path" }
    }
    catch { exit }
    #The folder the config file is in
    $configContainer = Split-Path $configpath
    #If the folder doesn't exist
    if ((Test-Path $configContainer) -eq $false) {
        #create the folder
        New-Item -Path $configContainer -Name (Split-Path $configContainer -Leaf) -ItemType Directory
    }
    try {
        #import the eixting config
        $config = Import-Clixml $configpath
    }
    catch {
        #If no config, initalize an empty hash table
        # $config = @{
        #     refreshinfo = @{}
        # }

	$config = @{}
    }

    $config.token = @{"Authorization" = "Bearer $token" }

    

    #Update all properties of the config, that have been passed in.
    if ($refreshinfo) {
        $config.refreshinfo = @{}
        $refreshinfo.psobject.properties | ForEach-Object {
        $config.refreshinfo."$($_.name)" = $_.value
    }
    }


    [void]($config | Export-Clixml -Path $configpath)
}
