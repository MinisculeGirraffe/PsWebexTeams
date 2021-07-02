function Set-WebexTeamsMessage {
    param (
        [Parameter(ValueFromPipelineByPropertyName, mandatory)]
        [Alias('id')]
        $messageId,
        [Parameter(ValueFromPipelineByPropertyName, mandatory)]
        $roomId,
        $text,
        $markdown,
        [Parameter()][string]$name = ""
    )
    
    $body = @{
        messageId = $messageId
        text      = $text
        markdown  = $markdown
        roomId    = $roomId
    }
    ($body.GetEnumerator() | Where-Object { -not $_.Value }) | ForEach-Object { $body.Remove($_.Name) }
    return (Invoke-WebexRestMethod -Method PUT -ResourceID ("/messages/$($body.messageId)") -body ($body | ConvertTo-Json))
}