
function Send-WebexTeamsMessage {
    param (
        $email,
        [Parameter(Mandatory)]
        $Text,
        [Parameter(ValueFromPipelineByPropertyName)]
        [alias('id')]
        $roomID,
        [Parameter(ValueFromPipelineByPropertyName)]
        [alias('id')]
        $personID,
        $parentID,
        [Parameter(ParameterSetName='text')]
        [string]$markdown
    )

    $body = @{
        toPersonEmail = $email
        text          = $Text
        roomId        = $roomID
        parentId = $parentID
        markdown = $markdown
    }

    ($body.GetEnumerator() | Where-Object { -not $_.Value }) | ForEach-Object { $body.Remove($_.Name) }
    $res = Invoke-RestMethod -Headers (Get-WebexTeamsCredential)`
        -ContentType "application/json" `
        -uri "https://api.ciscospark.com/v1/messages" `
        -Method Post `
        -body ($body | ConvertTo-Json)
    return $res
}
