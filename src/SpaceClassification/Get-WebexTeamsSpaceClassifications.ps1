function Get-WebexTeamsSpaceClassifications {
    return (Invoke-WebexRestMethod -Method GET -ResourceID ('/classifications'))    
}