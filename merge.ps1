$appName = $args[0]

if($appName.Length -eq 0)
{
    Write-Output("No app data was passed. Unable to merge. Use merge.ps1 <appName>")

    Exit
}

if(-not(Test-Path(".\merge")))
{
    Write-Output("No merge directory, nothing to merge.")

    Exit
}

(Get-ChildItem(".\merge\*")).FullName |
    ForEach-Object({ Join-Path($_, "*") }) |
        Copy-Item ".\$appName" -Recurse
