#!/bin/bash
# Original: toannv
# Updated by kienlt

# Set Base directory and remove old directory if exists
BASE_DIR=/data
VERSION=2.11.0

# Create folder for works
if [ ! -d "$BASE_DIR/ignite/" ]; then
	mkdir -p $BASE_DIR/ignite/
fi

# Check file exists
FILE=$BASE_DIR/apache-ignite-$VERSION-bin.zip
if [ ! -f "$FILE" ]; then
    wget https://archive.apache.org/dist/ignite/$VERSION/apache-ignite-$VERSION-bin.zip -O $BASE_DIR/apache-ignite-$VERSION-bin.zip
fi

# Unzip downloaded file
unzip -d $BASE_DIR/ignite/ $BASE_DIR/apache-ignite-$VERSION-bin.zip

echo "Copy libs"
cp -r $BASE_DIR/ignite/apache-ignite-$VERSION-bin/libs/optional/ignite-rest-http/ $BASE_DIR/ignite/apache-ignite-$VERSION-bin/libs/ignite-rest-http/
cp -r $BASE_DIR/ignite/apache-ignite-$VERSION-bin/libs/optional/ignite-opencensus/ $BASE_DIR/ignite/apache-ignite-$VERSION-bin/libs/ignite-opencensus/
cp -r $BASE_DIR/ignite/apache-ignite-$VERSION-bin/libs/optional/ignite-direct-io/ $BASE_DIR/ignite/apache-ignite-$VERSION-bin/libs/ignite-direct-io/
cp -r $BASE_DIR/ignite/apache-ignite-$VERSION-bin/libs/optional/ignite-compress/ $BASE_DIR/ignite/apache-ignite-$VERSION-bin/libs/ignite-compress/
cp -r $BASE_DIR/ignite/apache-ignite-$VERSION-bin/libs/optional/ignite-log4j/ $BASE_DIR/ignite/apache-ignite-$VERSION-bin/libs/ignite-log4j/

# Set env
export BASE_DIR=/data/
export IGNITE_HOME=$BASE_DIR/ignite/apache-ignite-$VERSION-bin

# Create start service file
cat > $BASE_DIR/ignite/startIgnite.sh << EOF
#!/bin/bash


$BASE_DIR/ignite/apache-ignite-$VERSION-bin/bin/ignite.sh \
    -J-Xms512m \
    -J-Xmx4500m \
    -J-Djava.net.preferIPv4Stack=true \
    -J-XX:+AlwaysPreTouch \
    -J-XX:+UseG1GC \
    -J-XX:+ScavengeBeforeFullGC \
    -J-XX:+DisableExplicitGC \
    -J-XX:MaxDirectMemorySize=512m
EOF

chmod 755 $BASE_DIR/ignite/startIgnite.sh


# Setup service file
cat > /lib/systemd/system/ignite.service << EOF
[Unit]
Description=Apache Ignite Service
After=network.target

[Service]
WorkingDirectory=$BASE_DIR/ignite
PrivateDevices=yes
ProtectSystem=full
Type=simple
ExecReload=/bin/kill -HUP $MAINPID
KillMode=mixed
KillSignal=SIGTERM
TimeoutStopSec=10
ExecStart=$BASE_DIR/ignite/startIgnite.sh
SyslogIdentifier=Ignite
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
Alias=ignite.service
EOF

# Reload and enable service
chmod 755 /lib/systemd/system/ignite.service
systemctl daemon-reload
systemctl enable ignite.service


echo "Config sysctl"
sysctl -w vm.swappiness=0
sysctl -w vm.zone_reclaim_mode=0
sysctl -w vm.dirty_writeback_centisecs=500
sysctl -w vm.dirty_expire_centisecs=500


echo "Clear log."
journalctl --rotate
journalctl --vacuum-time=1s

