Get-ChildItem -Recurse -Path (Join-Path -Path $PSScriptRoot -ChildPath "src") | ForEach-Object {
    if ($_.Extension -eq '.ps1') {
        . $_.FullName
        Write-Verbose "Importing $($_.FullName)"
    }

}