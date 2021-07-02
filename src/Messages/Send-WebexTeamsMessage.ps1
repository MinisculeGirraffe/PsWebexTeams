function Send-WebexTeamsMessage {
    param (
        $email,
        [Parameter(Mandatory)]
        $Text,
        [Parameter(ValueFromPipelineByPropertyName)]
        [alias('id')]
        $roomID,
        [Parameter(ValueFromPipelineByPropertyName)]
        $personID,
        $parentID,
        [Parameter(ParameterSetName = 'text')][string]$markdown,
        [Parameter()][string]$name = ""
    )

    $body = @{
        toPersonEmail = $email
        text          = $Text
        roomId        = $roomID
        parentId      = $parentID
        markdown      = $markdown
    }

    ($body.GetEnumerator() | Where-Object { -not $_.Value }) | ForEach-Object { $body.Remove($_.Name) }
    return (Invoke-WebexRestMethod -Method POST -ResourceID ("/messages") -body ($body | ConvertTo-Json))
}