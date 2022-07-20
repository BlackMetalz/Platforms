### Ref:
- https://docs.cloudera.com/documentation/enterprise/5-2-x/topics/cdh_ig_hbase_troubleshooting.html
- https://support.datafabric.hpe.com/s/article/How-to-modify-hbase-thrift-client-code-if-Hbase-Thrift-Service-enables-framed-transport-and-compact-protocol?language=en_US

## Issue: Thrift Server Crashes after Receiving Invalid Data
The Thrift server may crash if it receives a large amount of invalid data, due to a buffer overrun.

#### Why this happens

The Thrift server allocates memory to check the validity of data it receives. If it receives a large amount of invalid data, it may need to allocate more memory than is available. This is due to a limitation in the Thrift library itself.

#### What to do

To prevent the possibility of crashes due to buffer overruns, use the framed and compact transport protocols. These protocols are disabled by default, because they may require changes to your client code. The two options to add to your hbase-site.xml are hbase.regionserver.thrift.framed and hbase.regionserver.thrift.compact. Set each of these to true, as in the XML below. You can also specify the maximum frame size, using the hbase.regionserver.thrift.framed.max_frame_size_in_mb option.

```
<property> 
  <name>hbase.regionserver.thrift.framed</name> 
  <value>true</value> 
</property> 
<property> 
  <name>hbase.regionserver.thrift.framed.max_frame_size_in_mb</name> 
  <value>2</value> 
</property> 
<property> 
  <name>hbase.regionserver.thrift.compact</name> 
  <value>true</value> 
</property>
```

We also need to tell client changes

Solution<Ensure you call out if authorized access / privileges are needed by customers> Following are the steps taken to resolve the issue: 1. <Step 1> – <flags that indicate that Step 1 was a success> 2. <Step 2> – <flags that indicate Step 2 success>
1. If framed transport is enabled
We need to modify FROM:
```
from thrift.transport import TTransport
transport = TTransport.TBufferedTransport(TSocket.TSocket(host, port))
```
 TO:
 ```
from thrift.transport.TTransport import TFramedTransport
transport = TFramedTransport(TSocket.TSocket(host, port))
```

 2. If compact protocol is enabled
 We need to modify FROM:
 ```
from thrift.protocol import TBinaryProtocol
protocol = TBinaryProtocol.TBinaryProtocolAccelerated(transport)
```
 TO:
 ```
from thrift.protocol import TCompactProtocol
protocol = TCompactProtocol.TCompactProtocol(transport)
 ```
One complete example code in python is as below:
```
from thrift.transport import TSocket
#from thrift.protocol import TBinaryProtocol
from thrift.protocol import TCompactProtocol
#from thrift.transport import TTransport
from thrift.transport.TTransport import TFramedTransport
from hbase import Hbase
 
host = "localhost"
port = "9090"
tablename = "/user/mapr/some_table"
numRows = 100
columnName = "cf1:col1"
 
# Connect to HBase Thrift server
#transport = TTransport.TBufferedTransport(TSocket.TSocket(host, port))
transport = TFramedTransport(TSocket.TSocket(host, port))
 
#protocol = TBinaryProtocol.TBinaryProtocolAccelerated(transport)
protocol = TCompactProtocol.TCompactProtocol(transport)
 
# Create and open the client connection
client = Hbase.Client(protocol)
transport.open()
 
# Scan the maprdb table
scan = Hbase.TScan(startRow="111", stopRow="222")
scannerId = client.scannerOpenWithScan(tablename, scan, None)
row = client.scannerGet(scannerId)
rowList = client.scannerGetList(scannerId,numRows)
 
while rowList:
          for row in rowList:
                    message = row.columns.get(columnName).value
                    rowKey = row.row
                    print "rowKey = " + rowKey + ", columnValue = " + message
          rowList = client.scannerGetList(scannerId,numRows)
 
client.scannerClose(scannerId)
 
transport.close()
```
