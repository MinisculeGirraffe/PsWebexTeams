function  Set-WebexTeamsCredential {
    param (
        [Parameter(Mandatory = $true)][string]$name,
        $refreshinfo
    )

    #region Configure/Check FilePath
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
    #endregion

    #Test Keybase
    if(!(Test-Path ($configContainer + "\PSWebexTeamsConfig-$name.xml" ))){
        #Create Keybase
        Read-Host "Please enter API Token" -AsSecureString | Export-Clixml -Path ($configContainer + "\PSWebexTeamsConfig-$name.xml" )
        Write-Output "Token object created."
    }else{
        Write-Output "Token object has already been created...Importing..."
        $keypath = Import-Clixml -Path ($configContainer + "\PSWebexTeamsConfig-$name.xml")
        $tokenobj = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($keypath))
        $config = @{}
        $config.token = @{"Authorization" = "Bearer $tokenobj" }
    }
    #Update all properties of the config, that have been passed in.
    if ($refreshinfo) {
        $config.refreshinfo = @{}
        $refreshinfo.psobject.properties | ForEach-Object {
        $config.refreshinfo."$($_.name)" = $_.value
    }
    }
}