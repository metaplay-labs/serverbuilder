Write-Output("Serverbuilder, a toolchain created by Metaplay Labs`n")

if(-not([System.IO.File]::Exists(".\steamcmd.zip")) -and(-not([System.IO.File]::Exists(".\steamcmd.exe"))))
{
    Write-Output("Downloading SteamCMD from remote steam servers...")

    $webClient = New-Object("System.Net.WebClient")
    $webClient.DownloadFile("https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip", ".\steamcmd.zip")
}
else
{
    Write-Output("Found an existing SteamCMD installation.")
}

if(-not([System.IO.File]::Exists(".\steamcmd.exe")))
{
    if([System.IO.File]::Exists(".\steamcmd.zip"))
    {
        Write-Output("SteamCMD archive installed, unpacking...")
    
        Expand-Archive("steamcmd.zip")
        Remove-Item("steamcmd.zip")
    
        Move-Item(".\steamcmd\steamcmd.exe", ".\steamcmd.exe")
        Remove-Item(".\steamcmd")
    }
    else
    {
        Write-Output("Failed to download SteamCMD.")
    
        Exit
    }    
}

$appName = $args[0]
$appId = $args[1]

if($appName.Length -eq 0 -or $appId.Length -eq 0)
{
    Write-Output("No app data was passed. Unable to update. Use build.ps1 <appName> <appId>")

    Exit
}

Write-Output("Updating $appName (appid $appId)")

Invoke-Expression(".\update.ps1 $appName $appId")

Write-Output("Merging modded files into $appName...")

Invoke-Expression(".\merge.ps1 $appName")

Write-Output("Build done!`n")
