#!/bin/bash

cd /skywalking/agent/plugins/


cat > delete-jar <<EOF
activemq
aerospike
armeria
avro
canal
cassandra
clickhouse
cxf
dubbo
finagle
grizzly
grpc
h2
hbase
impala
influxdb
jersey
kafka
kylin
mssql
neo4j
nutz
play
postgresql
pulsar
quasar
rabbitmq
rocketMQ
rocketmq
servicecomb
sharding-sphere
shardingsphere
solrj
struts2
vertx
xmemcached
brpc
jsonrpc4j
micronaut
motan
nats
resteasy
sofa
thrift
websphere
graphql
light4j
elastic-job
elasticjob
spymemcached
EOF

for line in `cat delete-jar`
do
    ls |grep ${line} |xargs /bin/rm -rf
done



