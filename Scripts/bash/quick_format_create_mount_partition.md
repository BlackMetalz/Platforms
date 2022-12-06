Copy and paste. Ez game ez life

```
sudo -i
mkfs.ext4 /dev/vdb
UUID=$(blkid | grep /dev/vdb | cut -f 2 -d " " )
mkdir -p /data
echo -e "\n $UUID /data ext4 noatime,nodiratime 0 1" >> /etc/fstab
mount -a
df -h

```


- Updated version with gparted


```
parted /dev/vdb -s 'mktable gpt'
parted /dev/vdb -s 'mkpart primary 0 -1'
mkfs.ext4 /dev/vdb1
UUID=$(blkid | grep -E 'vdb1' | awk {'print $2'})
echo -e "\n $UUID /data ext4 noatime,nodiratime 0 1" >> /etc/fstab
mkdir -p /data
mount -a
df -h
```
