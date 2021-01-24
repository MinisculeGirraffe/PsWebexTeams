function New-WebexTeamsRoom {
    param (
        [Parameter(ValueFromPipelineByPropertyName, Mandatory)]
        $teamID,
        $title,
        $classificationID
    )

    $body = @{
        teamID           = $teamID
        title            = $title
        classificationID = $classificationID
    }

    ($body.GetEnumerator() | Where-Object { -not $_.Value }) | ForEach-Object { $body.Remove($_.Name) }
    try {
        $res = Invoke-RestMethod -Headers (Get-WebexTeamsCredential) `
            -ContentType "application/json" `
            -uri 'https://webexapis.com/v1/rooms' `
            -body ($body | ConvertTo-Json) `
            -Method Post
        
        return $res
    }
    catch {
        Write-Error ($_.ErrorDetails.Message | ConvertFrom-Json).message
    }
}