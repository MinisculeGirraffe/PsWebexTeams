function Get-WebexTeamsMessageDetails {
    param (
        [Parameter(ValueFromPipelineByPropertyName, mandatory = $true)]
        [alias('id')]
        [string]$messageId,
        [Parameter()][string]$name = ""
    )
    return (Invoke-WebexRestMethod -Method GET -ResourceID ("/messages/$messageId"))
}