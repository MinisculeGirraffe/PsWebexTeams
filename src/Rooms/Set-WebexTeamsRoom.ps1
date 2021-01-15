function Set-WebexTeamsRoom {
    param (
        [Parameter(ValueFromPipelineByPropertyName, Mandatory)]
        [alias('id')]
        [string]$roomID,
        [Parameter(Mandatory)]
        [string]$title,
        [string]$classificationID
        
    )
    $body = @{
        teamID           = $teamID
        title            = $title
        classificationID = $classificationID
    }

    ($body.GetEnumerator() | Where-Object { -not $_.Value }) | ForEach-Object { $body.Remove($_.Name) }

    $res = Invoke-RestMethod -Headers (Get-WebexTeamsCredential) `
        -ContentType "application/json" `
        -uri 'https://webexapis.com/v1/rooms' `
        -body ($body | ConvertTo-Json) `
        -Method Put
    return res
}