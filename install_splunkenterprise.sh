#!/bin/bash -v
echo -n "Enter new Splunk admin password and press [ENTER]: \n"
read -s password
echo -n "Enter Deployment Server and press [ENTER] (e.g. 192.168.1.33:8089): \n"
read deploymentclient
export SPLUNK_USER=splunk
export SPLUNK_BIN=/opt/splunk/bin/splunk
export SPLUNK_HOME=/opt/splunk
#DISABLE THP
cat >/etc/systemd/system/disable-transparent-huge-pages.service<<EOF
[Unit]
Description=Disable Transparent Huge Pages

[Service]
Type=oneshot
ExecStart=/bin/sh -c "echo never >/sys/kernel/mm/transparent_hugepage/enabled"
ExecStart=/bin/sh -c "echo never >/sys/kernel/mm/transparent_hugepage/defrag"
RemainAfterExit=true
[Install]
WantedBy=multi-user.target
EOF
systemctl enable disable-transparent-huge-pages.service
systemctl start disable-transparent-huge-pages.service
#DOWNLOAD AND INSTALL
wget -O /tmp/splunk-7.0.2-03bbabbd5c0f-Linux-x86_64.tgz 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=7.0.2&product=splunk&filename=splunk-7.0.2-03bbabbd5c0f-Linux-x86_64.tgz&wget=true'
tar xvzf /tmp/splunk-7.0.2-03bbabbd5c0f-Linux-x86_64.tgz -C /opt
cat >/opt/splunk/etc/system/local/deploymentclient.conf<<EOF
[deployment-client]
phoneHomeIntervalInSecs = 60

[target-broker:deploymentServer]
targetUri = $deploymentclient
EOF
useradd splunk
chown -R $SPLUNK_USER:$SPLUNK_USER /opt/splunk
runuser -l  splunk -c "$SPLUNK_BIN start --accept-license"
runuser -l  splunk -c "$SPLUNK_BIN edit user admin -password $password -role admin -auth admin:changeme"
$SPLUNK_BIN enable boot-start -user splunk
#INCREASE ULIMITS
mkdir -p /etc/systemd/system/splunk.service.d/
cat >/etc/systemd/system/splunk.service.d/filelimit.conf <<EOF
[Service]
LimitNOFILE=61440
LimitNPROC=61440
EOF
systemctl daemon-reload
sleep 15
systemctl restart splunk.service
