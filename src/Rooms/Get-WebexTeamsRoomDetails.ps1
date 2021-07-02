function Get-WebexTeamsRoomDetails {
    param (
        [Parameter(mandatory, ValueFromPipelineByPropertyName)]
        [Alias('id')]
        $roomID,
        [Parameter()][string]$name = ""
    )
    return (Invoke-WebexRestMethod -Method GET -ResourceID ('/rooms/' + $roomID))
}