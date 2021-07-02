Function Invoke-WebexRestMethod {
    [CmdletBinding()]
    Param (
    [Parameter(Mandatory)][ValidateNotNullOrEmpty()][String]$ResourceID,
    [Parameter()][ValidateSet('GET','POST','PUT','DELETE')][String]$Method,
    [Parameter()]$body
    )
    $uri = 'https://webexapis.com/v1' + $ResourceID
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    try{
        if($null -ne $body){
            return (Invoke-RestMethod -Method $Method -Uri $uri -Headers  (Get-WebexTeamsCredential -name (Read-DefaultTokenName)) -ContentType 'application/json' -Body $body).items
        }else{
            return (Invoke-RestMethod -Method $Method -Uri $uri -Headers  (Get-WebexTeamsCredential -name (Read-DefaultTokenName)) -ContentType 'application/json').items
        }
    }catch{
        Write-Error ($_.ErrorDetails.Message | ConvertFrom-Json).message
    }
}