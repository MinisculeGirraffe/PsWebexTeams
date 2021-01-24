function Get-WebexTeamsMessage {
    param (
        [Parameter(ValueFromPipelineByPropertyName, mandatory = $true)]
        [Alias('id')]
        $roomId,
        [datetime]$before,
        [string]$beforeMessage,
        [ValidateRange(1, [Int32]::MaxValue)]
        [int32]$max = [Int32]::MaxValue
    )
    $body = @{
        roomId        = $roomId
        before        = $before
        beforeMessage = $beforeMessage
        max           = $max
    }
    ($body.GetEnumerator() | Where-Object { -not $_.Value }) | ForEach-Object { $body.Remove($_.Name) }
    $res = Invoke-RestMethod -Headers (Get-WebexTeamsCredential) `
        -ContentType "application/json" `
        -uri 'https://webexapis.com/v1/messages' `
        -body $body
    return $res.items
}