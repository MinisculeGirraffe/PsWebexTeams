function Get-WebexTeamsUser {
    param (
        [Parameter(ValueFromPipelineByPropertyName)]
        [alias('mail')]
        [string]$Email,
        [string]$DisplayName,
        [Parameter(ValueFromPipelineByPropertyName)]
        $id,
        [Parameter(ValueFromPipelineByPropertyName)]
        $orgId,
        [Parameter(ValueFromPipelineByPropertyName)]
        $locationID,
        $max,
        [Parameter()][string]$name = ""
    )
    $body = @{
        id         = $id
        email      = $Email
        orgID      = $orgId
        locationID = $locationID
        max        = $max
        displayName = $DisplayName
    }
    ($body.GetEnumerator() | Where-Object { -not $_.Value }) | ForEach-Object { $body.Remove($_.Name) }
    return (Invoke-WebexRestMethod -Method GET -ResourceID ('/people') -body $body)
}