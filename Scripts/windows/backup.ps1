# Author: Luong Trung Kien
# Backup folder listed in IIS config file
# This scripts is my first script in powershell which costs 8 hours to begin, write, testing, finish and deploy to production usage
$paths = Get-Content -Path C:\Windows\System32\inetsrv\config\applicationHost.config | Where-Object {$_ -like '*physicalPath*'}
$winrar = "C:\Program Files\WinRAR\Rar.exe"
#$7zip = "C:\Program Files\7-Zip\7z.exe"
$date = Get-Date -UFormat %Y%m%d
$backup_location = "D:\Backup_Hosting\"

# format date: YYYY MM DD %d%m%Y
#$date

$paths = $paths -replace ".*physicalPath=" -replace "/>" -replace [regex]::Escape('"%SystemDrive%\inetpub\wwwroot"') -notmatch '^\s*$' -replace [regex]::Escape('"')

# $backup_path = $backup_location  + $date + "\"

foreach($path in $paths ){
 
    [string[]] $files = $path -replace '.*Hosting' -replace [regex]::Escape("\") -replace ".vn*", ".vn_" -replace " " -replace [regex]::Escape('"')

    $filenames = $backup_location +  $files + "_" + $date + ".zip"

    #$filenames
    foreach($filename in $filenames) {
        & $winrar a -r $filename $path
    }
}
