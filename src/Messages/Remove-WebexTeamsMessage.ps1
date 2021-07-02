function Remove-WebexTeamsMessage {
    param (
        [Parameter(ValueFromPipelineByPropertyName, mandatory = $true)]
        [alias('id')]
        [string]$messageId,
        [Parameter()][string]$name = ""
    )
    return (Invoke-WebexRestMethod -Method DELETE -ResourceID ("/messages/$messageId"))
}