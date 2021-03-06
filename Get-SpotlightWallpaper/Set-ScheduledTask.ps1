#### 05-22-2020 entropyth
#### Create Scheduled Task to run Script

$taskName = "Spotlight Wallpaper Sync"

Write-Host -ForegroundColor Green "#############`nCreating scheduled task to run Get-SpotlightWallpaper script daily`n#############"

## Safety Checks

# Check for existing scheduled task
If (Get-ScheduledTask -TaskPath \ | ?{ $_.TaskName -eq $taskName }) {
    Write-Host -ForegroundColor Red "Task: `"$taskName`" already exists. `nexiting."
    exit
}
# Check script is in current directory
If (!("$pwd\Get-SpotlightWallpaper.ps1")) {
    Write-Host -ForegroundColor Red "Script is not located in current directory. `nOnly run from Path intended for scheduled task.`nexiting."
    exit
}

# Create Scheduled Task
$A = New-ScheduledTaskAction -Execute "c:\windows\system32\WindowsPowerShell\v1.0\powershell.exe" -Argument "-noprofile -executionpolicy bypass -file `"$pwd\Get-SpotlightWallpaper.ps1`""
$T = New-ScheduledTaskTrigger -Daily -DaysInterval 1 -At 12pm
$P = New-ScheduledTaskPrincipal "$env:COMPUTERNAME\$env:USERNAME"
$S = New-ScheduledTaskSettingsSet
$D = New-ScheduledTask -Action $A -Principal $P -Trigger $T -Settings $S
Register-ScheduledTask $taskName -InputObject $D > $null

Write-Host "Running `"$taskName`""
Start-ScheduledTask -TaskName "$taskName"