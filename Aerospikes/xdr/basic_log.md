Ref here: https://www.aerospike.com/docs/reference/serverlogmessages/
```
INFO (xdr): (xdr.c:586) summary: throughput 7814 inflight 11 dlog-outstanding 23928614 dlog-delta-per-sec 2720.0
```

Parameters:
throughput: The current throughput, shipping to destination cluster(s). When shipping to multiple clusters the throughput will represent the combined throughput to all destination clusters. Corresponds to the xdr_throughput statistic.

inflight: The number of records that are inflight, meaning that have been sent to the destination cluster(s) but for which a response has not been received yet. Corresponds to the xdr_ship_inflight_objects statistic.

dlog-outstanding: The number of record's digests yet to be processed in the digest log. In parenthesis, the average change normalized to digests per second (over the 10 seconds interval separating those log lines). Corresponds to the xdr_ship_outstanding_objects statistic.

dlog-delta-per-sec: The variation of the dlog-outstanding normalized on a per second basis. Gives an idea whether the number of entries in the digestlog is increasing or decreasing over time and at what pace.

```
INFO (xdr): (xdr.c:596) detail: sh 3017637 ul 75 lg 29123214 rlg 16103 rlgi 890573 rlgo 1510637 lproc 5194500 rproc 1456711 
lkdproc 0 errcl 0 errsrv 54122 hkskip 110199 hkf 102750 flat 0
```

Parameters:
sh: The cumulative number of records that have been attempted to be shipped since this node started, across all datacenters. If a record is shipped to 3 different data centers, then this number will increment by 3. Corresponds to the sum of the xdr_ship_success, xdr_ship_source_error and xdr_ship_destination_error statistics.

ul: The number of record's digests that have been written to the node but not logged yet to the digestlog (unlogged).

lg: The number of record's digests that have been logged this includes both master and replica records but a node only ships records for which it owns the master partition and will process records belonging to its replica partitions only when a neighboring source node goes down.

rlog: Relogged digests. The number of record's digests that have been relogged on this node due to temporary failures when attempting to ship. Corresponds to the dlog_relogged statistic.

rlgi: Relogged incoming digests. The number of record's digest that another node sent to this node (typically prole side relog or partition ownership change). Corresponds to the xdr_relogged_incoming statistic.

rlgo: Relogged outgoing digests. The number of record's digest log entries that were sent to another node (typically prole side relog or partition ownership change). Corresponds to the xdr_relogged_outgoing statistic.

lproc: The number of record's digests that have been processed locally. A processed digest does not necessarily imply a shipped record (for example, replica digests don't get shipped unless a source node is down, and hotkeys also don't have all their updates necessarily shipped). Corresponds to the dlog_processed_main statistics.

rproc: The number of replica record's digests that have been processed by this node. A node will process records belonging to its replica partitions only when a neighboring source node goes down. Corresponds to the dlog_processed_replica statistic.

lkdproc: The number of record's digests that have been processed as part of a linked down session. A link down session is spawned when a full destination cluster is down or not reachable. Corresponds to the dlog_processed_link_down statistic.

errcl: The number of errors encountered when attempting to ship due to the embedded client. For example, if the local XDR embedded client is having issues or delays in establishing connections. Corresponds to the xdr_ship_source_error statistic.

errsrv: The number of errors encountered when attempting to ship due to the destination cluster. For example if the destination cluster is temporarily overloaded. Corresponds to the xdr_ship_destination_error statistic.

hkskip: Hotkey skipped. Represents the number of record's digests that are skipped due to an already existing entry in the reader's thread cache (meaning a version of this record was just shipped). Corresponds to the xdr_hotkey_skip statistic.

hkf: Hotkey fetched. Represents the number of record's digest that are actually fetched and shipped because their cache entries expired and were dirty. Corresponds to the xdr_hotkey_fetch statistics.

flat: The average time in milliseconds to fetch records locally (this is an exponential moving average - 95/5). Corresponds to the xdr_read_latency_avg statistic.

```
INFO (xdr): (xdr_dlog.c:106) dlog: free-pct 98 reclaimed 1577600 glst 1588733829338 (2020-05-06 02:57:09 GMT)
```
Provides digest log (dlog) related information.

Occurs: Every 1 minute.

Parameters:
free-pct: Percentage of the digest log free and available for use. Corresponds to the dlog_free_pct statistic.

reclaimed: Indicates how many digests were safely 'removed' from the digestlog. As shipping successfully proceeds, and records are shipped, digests which for sure are not necessary anymore can have their space reclaimed in the digest log. A linked down (destination cluster down or unreachable) is an example where digest log space cannot be reclaimed.

glst: The minimum last ship time across all nodes in the cluster. Corresponds to the xdr_global_lastshiptime statistics. This is used to know until what point can slots in the digest log be reclaimed, by keeping track of the oldest last ship time across all nodes in the cluster.

```
INFO (xdr): (xdr.c:544) [REMOTE_DC_2]: dc-state CLUSTER_UP timelag-sec 0 lst 1588733830373 mlst 1588733830373 (2020-05-06 02:57:10 GMT) fnlst 0 (-) wslst 0 (-) shlat-ms 1472 errcl 0 errsrv 0 rsas-ms 0.000 rsas-pct 0.0
```

Occurs: Every 1 minute, for each configured destination cluster (or DC).

Parameters:
[DC_NAME]: Name and status of the DC. Here are the different statuses: CLUSTER_INACTIVE, CLUSTER_UP, CLUSTER_DOWN, CLUSTER_WINDOW_SHIP. Corresponds to the dc_state statistic.

timelag-sec: The lag in seconds. This is computed as the difference between the current time and the time-stamp of the record that was last successfully shipped. This provides a sense of how 'far behind' the destination cluster lags behind the source cluster. This does not correspond to the time it will take the source cluster to 'catch up', neither does it necessarily relates to the number of outstanding digests to be processed. Corresponds to the dc_timelag statistic.

lst: The overall last ship time for the node (the minimum of all last ship times on this node).

mlst: The main last ship time (the last ship time of the dlogreader).

fnlst: The failed node last ship time (the minimum of the last ship times of all failed node shippers running on this node).

wslst: The window shipper last ship time (the minimum of the last ship times of all window shippers running on this node).

shlat-ms: Corresponds to the xdr_ship_latency_avg statistic.

rsas-ms: Average sleep time for each write to the DC for the purpose of throttling. Corresponds to the dc_ship_idle_avg statistic. (Stands for remote ship average sleep ms).

rsas-pct: Percentage of throttled writes to the DC. Corresponds to the dc_ship_idle_avg_pct statistic. (Stands for remote ship average sleep pct).

con: Number of open connection to the DC. If the DC accepts pipeline writes, there will be 64 connections per destination node. Only available as of version 3.11.1.1. Corresponds to the dc_open_conn statistic.

errcl: Number of client layer errors while shipping records for this DC. Errors include timeout, bad network fd, etc. Only available as of version 3.11.1.1. Corresponds to the dc_ship_source_error statistic.

errsrv: Number of errors from the remote cluster(s) while shipping records for this DC. Errors include out-of-space, key-busy, etc. Only available as of version 3.11.1.1. Corresponds to the dc_ship_destination_error statistic.

sz: The cluster size of the destination DC.. Only available as of version 3.11.1.1. Corresponds to the dc_size statistic.



