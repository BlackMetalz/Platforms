:: Delete backup files older than 1 days
ForFiles /p "D:\Backup_Hosting" /s /d -1 /c "cmd /c del @file"
