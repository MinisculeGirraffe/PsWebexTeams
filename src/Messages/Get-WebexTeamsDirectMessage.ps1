function  Get-WebexTeamsDirectMessage {
    param (
        [Parameter(ValueFromPipelineByPropertyName)]
        [Alias('id')]
        $personId,
        $parentId,
        $email
        
    )
    $body = @{
        personId = $personId
        parentId = $parentId
        personEmail = $email
    }
    ($body.GetEnumerator() | Where-Object { -not $_.Value }) | ForEach-Object { $body.Remove($_.Name) }
    $res = Invoke-RestMethod -Headers (Get-WebexTeamsCredential) `
        -ContentType "application/json" `
        -uri 'https://webexapis.com/v1/messages/direct' `
        -body $body
    return $res.items
}