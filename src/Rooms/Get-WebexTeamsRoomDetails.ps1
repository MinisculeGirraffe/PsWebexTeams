function Get-WebexTeamsRoomDetails {
    param (
        [Parameter(mandatory, ValueFromPipelineByPropertyName)]
        [Alias('id')]
        $roomID
    )
    try {
        $res = Invoke-RestMethod -Headers (Get-WebexTeamsCredential) `
            -ContentType "application/json" `
            -uri "https://webexapis.com/v1/rooms/$roomID" `
            -Method Get
        return $res
    }
    catch {
        Write-Error ($_.ErrorDetails.Message | ConvertFrom-Json).message
    }
}