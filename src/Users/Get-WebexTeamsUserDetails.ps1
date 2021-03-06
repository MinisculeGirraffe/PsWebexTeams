function Get-WebexTeamsUserDetails {
    param (
        [Parameter(ValueFromPipelineByPropertyName)]
        $id
    )
    try {
        $res = Invoke-RestMethod -Headers (Get-WebexTeamsCredential) `
            -ContentType "application/json" `
            -uri "https://webexapis.com/v1/people/$id" `
    
        return $res.items
    }
    catch {
        Write-Error ($_.ErrorDetails.Message | ConvertFrom-Json).message
    }
    
}