function Get-WebexTeamsSpaceClassifications {
    $res = Invoke-RestMethod -Headers (Get-WebexTeamsCredential) `
        -uri 'https://webexapis.com/v1/classifications' 
    return $res.items
    
}