function Set-WebexTeamsRoom {
    param (
        [Parameter(ValueFromPipelineByPropertyName, Mandatory)]
        [alias('id')]
        [string]$roomId,
        [Parameter(Mandatory)]
        [string]$title,
        [string]$classificationID,
        [Parameter()][string]$name = ""
    )
    $body = @{
        roomId           = $roomId
        title            = $title
        classificationID = $classificationID
    }
    ($body.GetEnumerator() | Where-Object { -not $_.Value }) | ForEach-Object { $body.Remove($_.Name) }
    return (Invoke-WebexRestMethod -Method PUT -ResourceID ('/rooms') -body ($body | ConvertTo-Json))
}