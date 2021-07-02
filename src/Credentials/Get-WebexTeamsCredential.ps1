function Get-WebexTeamsCredential {
    param(
        [Parameter()][string]$name = "",
        [bool]$SetDefault = $true
    )
    if($SetDefault){
        if( ($null -eq $global:name) -and ("" -eq $name)){
            $global:name = Read-DefaultTokenName
        }
    }
    if($null -eq $global:name){
        if("" -eq $name){$name = Read-DefaultTokenName}
    }else{ $name = $global:name}
    try {
        return @{"Authorization" = "Bearer " + (([Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR((Import-Clixml -Path (((Resolve-WebexTeamsConfigPath) -replace ".xml") + "-" + ($name) + ".xml"))))))}
    }catch { 
        throw "Unable to resolve config path"
        exit 
    }
}