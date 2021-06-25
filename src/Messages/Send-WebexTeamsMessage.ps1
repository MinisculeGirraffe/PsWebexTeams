function Send-WebexTeamsMessage {
    param (
        $email,
        [Parameter(Mandatory)]
        $Text,
        [Parameter(ValueFromPipelineByPropertyName)]
        [alias('id')]
        $roomID,
        [Parameter(ValueFromPipelineByPropertyName)]
        $personID,
        $parentID,
        [Parameter(ParameterSetName = 'text')][string]$markdown,
        [string]$name
    )

    $body = @{
        toPersonEmail = $email
        text          = $Text
        roomId        = $roomID
        parentId      = $parentID
        markdown      = $markdown
    }

    ($body.GetEnumerator() | Where-Object { -not $_.Value }) | ForEach-Object { $body.Remove($_.Name) }
    try {
        $res = Invoke-RestMethod -Headers (Get-WebexTeamsCredential -name $name)`
            -ContentType "application/json" `
            -uri "https://api.ciscospark.com/v1/messages" `
            -Method Post `
            -body ($body | ConvertTo-Json)
        return $res
    }
    catch {
        Write-Error ($_.ErrorDetails.Message | ConvertFrom-Json).message
    }
}