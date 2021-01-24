function Remove-WebexTeamsMessage {
    param (
        [Parameter(ValueFromPipelineByPropertyName, mandatory = $true)]
        [alias('id')]
        [string]$messageId
    )
    try {
        $res = Invoke-RestMethod -Headers (Get-WebexTeamsCredential) `
            -ContentType "application/json" `
            -uri "https://webexapis.com/v1/messages/$messageId" `
            -Method Delete
        return $res
    }
    catch {
        Write-Error ($_.ErrorDetails.Message | ConvertFrom-Json).message
    }
}