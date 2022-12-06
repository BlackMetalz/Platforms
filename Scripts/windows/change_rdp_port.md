### Create new file with extension .reg. Edit port value in dword:hex_value. You have to convert int to hex with 
number of port you want

```
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp]
"PortNumber"=dword:0000095b
```
