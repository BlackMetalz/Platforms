```
while IFS= read -r line; do echo "${line%%:*}"; done < /etc/passwd
```
