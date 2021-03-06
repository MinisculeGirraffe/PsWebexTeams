function  Get-WebexTeamsDirectMessage {
    param (
        [Parameter(ValueFromPipelineByPropertyName)]
        [Alias('id')]
        $personId,
        $parentId,
        $email,
        [string]$name 
    )
    $body = @{
        personId    = $personId
        parentId    = $parentId
        personEmail = $email
    }
    ($body.GetEnumerator() | Where-Object { -not $_.Value }) | ForEach-Object { $body.Remove($_.Name) }
    try {
        $res = Invoke-RestMethod -Headers (Get-WebexTeamsCredential -name $name) `
            -ContentType "application/json" `
            -uri 'https://webexapis.com/v1/messages/direct' `
            -body $body
        return $res.items
    }
    catch {
        Write-Error ($_.ErrorDetails.Message | ConvertFrom-Json).message
    }
}