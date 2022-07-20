## Source: https://opendistro.github.io/for-elasticsearch-docs/docs/im/ism/
## Useful read: https://discuss.opendistrocommunity.dev/t/help-needed-for-creating-a-template-for-merging-deleting-old-indices/3631/4
- Create new policy query
```
PUT _opendistro/_ism/policies/wtf
{
  "policy": {
    "description": "Example policy.",
    "default_state": "open",
    "states": [
       {
            "name": "open",
            "actions": [],
            "transitions": [
                {
                    "state_name": "delete",
                    "conditions": {
                        "min_index_age": "1m"
                    }
                }
            ]
        },
        {
            "name": "delete",
            "actions": [
                {
                    "delete": {}
                }
            ],
            "transitions": []
        }
      ],
    "ism_template": {
      "index_patterns": ["k8s_logs_*"],
      "priority": 100
    }
  }
}
```


- Check in Index Management ( Kibana )
![image](https://user-images.githubusercontent.com/3434274/130496283-d0c699a7-ad5c-4a0d-bbb5-ddfcb50fe72d.png)


- It will takes 5 minutes to init the job.
- After that you will see your index deleted
