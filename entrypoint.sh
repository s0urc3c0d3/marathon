#!/bin/bash

#Obrain the IPs of ZK instances

cron 
crontab -r
echo "*/5 * * * * /gen_hosts.sh > /etc/hosts" > /tmp/mycron 
crontab /tmp/mycron

ZK_IPs=","

my_stack=$(curl -s rancher-metadata.rancher.internal/2015-12-19/self/stack/name)

for i in $(curl -s rancher-metadata.rancher.internal/2015-12-19/services/zookeeper/containers/ | awk -F= '{print $2}')
do
        ZK_IPs="${ZK_IPs},$(curl -s rancher-metadata.rancher.internal/2015-12-19/services/zookeeper/containers/${i}/primary_ip):2181"
done
ZK_IPs=$(echo $ZK_IPs | sed 's/,,//g')

java -jar ./bin/../target/marathon-assembly-1.4.5.jar --zk zk://${ZK_IPs}/marathon --enable_features $MARATHON_FEATURES --http_port $HTTP_PORT --https_port $HTTPS_PORT --master zk://${ZK_IPs}/mesos --hostname $MARATHON_HOSTNAME
