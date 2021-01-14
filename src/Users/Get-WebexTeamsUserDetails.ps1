function Get-WebexTeamsUserDetails {
    param (
        $id,
        [Parameter(ValueFromPipeline=$true)]
        $inputObject
    )
    if($null -eq $id) {$id -eq $inputObject.id}

    $res = Invoke-RestMethod -Headers (Get-WebexTeamsCredential) `
        -ContentType "application/json" `
        -uri "https://webexapis.com/v1/people/$id" `

    return $res
}