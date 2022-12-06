- completely disable WerFault.exe (Windows Error Reporting)


```
Windows Registry Editor Version 5.00

[HKEY_CURRENT_USER\Software\Microsoft\Windows\Windows Error Reporting]
"Disabled"=dword:00000001
"DontShowUI"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting]
"Disabled"=dword:00000001
"DontShowUI"=dword:00000001
```


credit: https://serverfault.com/questions/345292/completely-disable-this-program-has-stopped-working-etc-dialog
