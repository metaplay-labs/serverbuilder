if(-not([System.IO.File]::Exists(".\steamcmd.exe")))
{
    Write-Output("ERROR: SteamCMD installation not found, update impossible. (Did you run build.ps1?)")

    Exit
}

$appName = $args[0]
$appId = $args[1]

if($appName.Length -eq 0 -or $appId.Length -eq 0)
{
    Write-Output("No app data was passed. Unable to update. Use update.ps1 <appName> <appId>")
    
    Exit
}

Write-Output("Replacing variables in steam_script.txt...")

(Get-Content(".\steam_script.txt")).Replace("APP_NAME", $appName) | Set-Content(".\steam_script.txt")
(Get-Content(".\steam_script.txt")).Replace("APP_ID", $appId) | Set-Content(".\steam_script.txt")

Write-Output("Invoking SteamCMD! ($appName $appId)")

Invoke-Expression(".\steamcmd.exe +runscript .\steam_script.txt")

Write-Output("Backing up old variables in steam_script.txt...")

(Get-Content(".\steam_script.txt")).Replace($appName, "APP_NAME") | Set-Content(".\steam_script.txt")
(Get-Content(".\steam_script.txt")).Replace($appId, "APP_ID") | Set-Content(".\steam_script.txt")
