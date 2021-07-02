function  Get-WebexTeamsDirectMessage {
    param (
        [Parameter(ValueFromPipelineByPropertyName)]
        [Alias('id')]
        $personId,
        $parentId,
        $email,
        [Parameter()][string]$name = ""
    )
    $body = @{
        personId    = $personId
        parentId    = $parentId
        personEmail = $email
    }
    ($body.GetEnumerator() | Where-Object { -not $_.Value }) | ForEach-Object { $body.Remove($_.Name) }
    return (Invoke-WebexRestMethod -Method GET -ResourceID ("/messages/direct") -body $body)
}