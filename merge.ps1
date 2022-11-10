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

$mergeFrom = ".\merge\"
$mergeTo = ".\$appName\"

Write-Output("Merging files from $mergeFrom to $mergeTo...")

foreach($item in (Get-ChildItem $mergeFrom))
{
    $fileFullPath = $item.FullName
	Write-Output($fileFullPath)

    Copy-Item -Path $fileFullPath -Destination $mergeTo -Force -Recurse
}
