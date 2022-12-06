FOR /F "usebackq tokens=3,4,5,6" %%a IN (`REG query "hklm\software\microsoft\windows NT\CurrentVersion" /v ProductName`) DO echo %%a %%b %%c %%d
