- When insert into aerospike. You will need a key go within namespaces and setname and key. So you can query data you inserted
by that key

Example in Go Client:

- This is Data of full query:

```
ql> select * from ns_aes_test.user_info

[
    [
        {
          "asd": "asd"
        },
        {
          "data": 1,
          "bin1": 42,
          "bin2": "An elephant is a mouse with an operating system",
          "bin3": [
            "Go",
            2009
          ],
          "2": "Info of user ID 2",
          "3": "Info of user ID 3",
          "1": "Info of user ID 1",
          "4": "7B 22 46 69 72 73 74 4E 61 6D 65 22 3A 22 42 6F 62 62 79 22 2C 20 22 4C 61 73 74 4E 61 6D 65 22 3A 22 4D 6F 74 68 65 72 66 75 63 6B 65 72 22 2C 22 41 67 65 22 3A 22 39 39 22 7D",
          "5": "{\"FirstName\":\"Bobby\", \"LastName\":\"Motherfucker\",\"Age\":\"99\"}"
        }
    ],
    [
        {
          "Status": 0
        }
    ]
]

```

- I used key = 1 to insert

```
key, err := aero.NewKey("ns_aes_test", "user_info", 1)
```

- after that I used `1` as the key for filter
Then i do query in aql:
```
aql> select * from ns_aes_test.user_info where PK=1

[
    [
        {
          "asd": "asd"
        }
    ],
    [
        {
          "Status": 0
        }
    ]
]
```

It returns what i wants.

Still finding a way to get all keys...



