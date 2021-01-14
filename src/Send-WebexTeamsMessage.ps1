
function Send-WebexTeamsMessage {
    param (
        $email,
        $Text,
        $roomID,
        [switch]$markdown
    )

    $body = @{
        toPersonEmail = $email
        text          = $Text
    }

    $res = Invoke-RestMethod -Headers (Get-WebexTeamsCredential)`
        -ContentType "application/json" `
        -uri "https://api.ciscospark.com/v1/messages" `
        -Method Post `
        -body ($body | ConvertTo-Json)
    return $res
}
