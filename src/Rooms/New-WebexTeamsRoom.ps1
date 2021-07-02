function New-WebexTeamsRoom {
    param (
        [Parameter(ValueFromPipelineByPropertyName, Mandatory)]
        $teamID,
        $title,
        $classificationID,
        [Parameter()][string]$name = ""
    )

    $body = @{
        teamID           = $teamID
        title            = $title
        classificationID = $classificationID
    }

    ($body.GetEnumerator() | Where-Object { -not $_.Value }) | ForEach-Object { $body.Remove($_.Name) }
    return (Invoke-WebexRestMethod -Method POST -ResourceID ('/rooms') -body ($body | ConvertTo-Json))
}