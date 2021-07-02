function Get-WebexTeamsUserDetails {
    param (
        [Parameter(ValueFromPipelineByPropertyName)]
        $id,
        [Parameter()][string]$name = ""
    )
    return (Invoke-WebexRestMethod -Method GET -ResourceID ('/people' + $id))
}