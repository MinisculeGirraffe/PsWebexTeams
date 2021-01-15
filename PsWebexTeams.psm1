Get-ChildItem -Recurse -Path (Join-Path -Path $PSScriptRoot -ChildPath "src") | ForEach-Object {
    Get-ChildItem -Path $_.FullName | ForEach-Object {
            . $_.FullName
            Write-Verbose "Importing $($_.FullName)"
        }
}