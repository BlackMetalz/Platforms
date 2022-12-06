### Something about awk need to remember

- Combine multiple line into single line with delimiter:

Input: `awk '{print $1}'`
```
08411c20-d6cf-476f-8546-c538556e845f
41d51a57-f958-49ac-b290-6d8bedc018f9
348e5364-1ac1-4ecf-b4b2-0f1178413a84
e8fabd19-cd79-4bdf-9105-d0a4718de7af
ed5d4c8c-befe-4482-8045-7f122883c629
523d533c-7a9f-45cb-be7d-99c62d871e39
6bb336b3-ff9a-41ce-8a5c-5d94167bb824
```

Handle: `awk '{print $1}' | awk -vRS='|' '$1=$1" "'`
Output:
```
08411c20-d6cf-476f-8546-c538556e845f  41d51a57-f958-49ac-b290-6d8bedc018f9 348e5364-1ac1-4ecf-b4b2-0f1178413a84 e8fabd19-cd79-4bdf-9105-d0a4718de7af ed5d4c8c-befe-4482-8045-7f122883c629 523d533c-7a9f-45cb-be7d-99c62d871e39 6bb336b3-ff9a-41ce-8a5c-5d94167bb824
```

Ref: https://unix.stackexchange.com/questions/463263/concatenate-multiple-lines-into-a-single-line-until-a-pattern-is-found 

