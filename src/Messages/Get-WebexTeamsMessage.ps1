function Get-WebexTeamsMessage {
    param (
        [Parameter(ValueFromPipelineByPropertyName,mandatory=$true)]
        [string]$roomId,
        [datetime]$before,
        [string]$beforeMessage,
        [int]$max
    )
    $body = @{
        roomId        = $roomId
        before        = $before
        beforeMessage = $beforeMessage
        max           = $max
    }
    ($body.GetEnumerator() | ? { -not $_.Value }) | % { $body.Remove($_.Name) }
    $res = Invoke-RestMethod -Headers (Get-WebexTeamsCredential) `
        -ContentType "application/json" `
        -uri 'https://webexapis.com/v1/messages' `
        -body $body
    return $res.items
}