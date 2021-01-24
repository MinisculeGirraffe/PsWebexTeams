function Set-WebexTeamsMessage {
    param (
        [Parameter(ValueFromPipelineByPropertyName, mandatory)]
        [Alias('id')]
        $messageId,
        [Parameter(ValueFromPipelineByPropertyName, mandatory)]
        $roomId,
        $text,
        $markdown
    )
    
    $body = @{
        messageId = $messageId
        text      = $text
        markdown  = $markdown
        roomId    = $roomId
    }

    ($body.GetEnumerator() | Where-Object { -not $_.Value }) | ForEach-Object { $body.Remove($_.Name) }
    try {
        $res = Invoke-RestMethod -Headers (Get-WebexTeamsCredential)`
            -ContentType "application/json" `
            -uri "https://api.ciscospark.com/v1/messages/$($body.messageID)" `
            -Method put `
            -body ($body | ConvertTo-Json)
        return $res
    } 
    catch {
        Write-Error ($_.ErrorDetails.Message | ConvertFrom-Json).message
    }

}