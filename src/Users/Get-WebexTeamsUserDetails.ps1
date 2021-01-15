function Get-WebexTeamsUserDetails {
    param (
        [Parameter(ValueFromPipelineByPropertyName)]
        $id
    )
    $res = Invoke-RestMethod -Headers (Get-WebexTeamsCredential) `
        -ContentType "application/json" `
        -uri "https://webexapis.com/v1/people/$id" `

    return $res.items
}