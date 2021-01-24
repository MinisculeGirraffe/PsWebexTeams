function Get-WebexTeamsSpaceClassifications {
    try {
        $res = Invoke-RestMethod -Headers (Get-WebexTeamsCredential) `
            -uri 'https://webexapis.com/v1/classifications' 
        return $res.items
    }
    catch {
        Write-Error ($_.ErrorDetails.Message | ConvertFrom-Json).message
    }
    
}