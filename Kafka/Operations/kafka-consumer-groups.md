-- List:
```
kafka-consumer-groups.sh --bootstrap-server localhost:9092 --list
```
-- Delete:
```
kafka-consumer-groups.sh --bootstrap-server localhost:9092 --delete --group group_name
```

-- State
```
kafka-consumer-groups --bootstrap-server 10.3.68.28:9092 --describe --group filebeat --state
```

Output demo:
```
GROUP                     COORDINATOR (ID)          ASSIGNMENT-STRATEGY  STATE           #MEMBERS
filebeat                  10.3.68.28:9092 (5)       range                Stable          4
```
with state stable and member != 0. You can not delete consumer group.
Stop consumer group all and u will see this:
```
Consumer group 'filebeat' has no active members.

GROUP                     COORDINATOR (ID)          ASSIGNMENT-STRATEGY  STATE           #MEMBERS
filebeat                  10.3.68.28:9092 (5)                            Empty           0
```

Now you can delete consumer group


-- Detail consumer group:
```
bin/kafka-consumer-groups.sh --describe --group mygroup --bootstrap-server localhost:9092
```
 Output demo:
```
GROUP           TOPIC           PARTITION  CURRENT-OFFSET  LOG-END-OFFSET  LAG             CONSUMER-ID                                   HOST            CLIENT-ID
filebeat        topic-name    2          51472879        51476533        3654            filebeat-9739b0f2-2887-47e0-b76d-f02128047268 /10.5.1.72      filebeat
filebeat        topic-name    1          51516422        51519473        3051            filebeat-9739b0f2-2887-47e0-b76d-f02128047268 /10.5.1.72      filebeat
filebeat        topic-name    4          51627824        51631229        3405            filebeat-9739b0f2-2887-47e0-b76d-f02128047268 /10.5.1.72      filebeat
filebeat        topic-name    0          51458450        51461892        3442            filebeat-9739b0f2-2887-47e0-b76d-f02128047268 /10.5.1.72      filebeat
filebeat        topic-name    3          51543993        51547109        3116            filebeat-9739b0f2-2887-47e0-b76d-f02128047268 /10.5.1.72      filebeat
filebeat        topic-name    10         51503740        51509670        5930            filebeat-f47fc673-beda-48fd-8827-16dc0b84469a /10.5.2.116     filebeat
filebeat        topic-name    14         51658378        51663042        4664            filebeat-f47fc673-beda-48fd-8827-16dc0b84469a /10.5.2.116     filebeat
filebeat        topic-name    12         51476250        51481312        5062            filebeat-f47fc673-beda-48fd-8827-16dc0b84469a /10.5.2.116     filebeat
filebeat        topic-name    13         51531200        51536629        5429            filebeat-f47fc673-beda-48fd-8827-16dc0b84469a /10.5.2.116     filebeat
filebeat        topic-name    11         51496804        51501475        4671            filebeat-f47fc673-beda-48fd-8827-16dc0b84469a /10.5.2.116     filebeat
filebeat        topic-name    18         51426520        51435769        9249            filebeat-a016a8b3-0991-4681-a947-f8a677338149 /10.5.2.81      filebeat
filebeat        topic-name    17         51487868        51548490        60622           filebeat-a016a8b3-0991-4681-a947-f8a677338149 /10.5.2.81      filebeat
filebeat        topic-name    15         51439218        51530117        90899           filebeat-a016a8b3-0991-4681-a947-f8a677338149 /10.5.2.81      filebeat
filebeat        topic-name    16         51393076        51544732        151656          filebeat-a016a8b3-0991-4681-a947-f8a677338149 /10.5.2.81      filebeat
filebeat        topic-name    19         51548927        51563319        14392           filebeat-a016a8b3-0991-4681-a947-f8a677338149 /10.5.2.81      filebeat
filebeat        topic-name    6          51166129        51530726        364597          filebeat-42c15bd5-6ef1-4dae-8c6b-e747f811f781 /10.5.2.187     filebeat
filebeat        topic-name    9          51355061        51524135        169074          filebeat-42c15bd5-6ef1-4dae-8c6b-e747f811f781 /10.5.2.187     filebeat
filebeat        topic-name    5          51345745        51567409        221664          filebeat-42c15bd5-6ef1-4dae-8c6b-e747f811f781 /10.5.2.187     filebeat
filebeat        topic-name    8          51364264        51473987        109723          filebeat-42c15bd5-6ef1-4dae-8c6b-e747f811f781 /10.5.2.187     filebeat
filebeat        topic-name    7          51286866        51559640        272774          filebeat-42c15bd5-6ef1-4dae-8c6b-e747f811f781 /10.5.2.187     filebeat

```
