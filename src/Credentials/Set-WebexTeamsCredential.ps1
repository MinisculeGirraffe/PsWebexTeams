function  Set-WebexTeamsCredential {
    param (
        [Parameter(Mandatory = $true)][string]$name
    )

    #region Configure/Check FilePath
    #Check that we can determine the path we should store the config
    try {
        $configpath = Resolve-WebexTeamsConfigPath
        if ($null -eq $configpath) { throw "Unable to resolve config path" }
    }
    catch { exit }
    $configContainer = Split-Path $configpath
    if ((Test-Path $configContainer) -eq $false) {
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
        Get-WebexTeamsCredential -name $name
    }
}