#!/bin/sh
CLICKHOUSE_HOSTS=${CLICKHOUSE_HOSTS:=host1:8123,host1:8123}
CLICKHOUSE_USER=${CLICKHOUSE_USER:="default"}
CLICKHOUSE_PASS=${CLICKHOUSE_PASS:=""}
CLICKHOUSE_CLUSTER_NAME=${CLICKHOUSE_CLUSTER_NAME:="default_cluster"}
GRAPHITE_HOST=${GRAPHITE_HOST:="localhost"}
GRAPHITE_PORT=${GRAPHITE_PORT:="2003"}

arr=(${CLICKHOUSE_HOSTS//,/ })
for host in $(echo ${arr[@]});do
	curl http://${CLICKHOUSE_USER}:${CLICKHOUSE_PASS}@${host}/?query=select%20concat%28%27${CLICKHOUSE_CLUSTER_NAME}%27%2C%27.%27%2ChostName%28%29%2C%27.%27%2C%27events%27%2C%27.%27%2Cevent%2C%27%20%27%2CtoString%28value%29%2C%27%20%27%2CtoString%28toUnixTimestamp%28now%28%29%29%29%29%20from%20system.events | nc ${GRAPHITE_HOST} ${GRAPHITE_PORT}
	curl http://${CLICKHOUSE_USER}:${CLICKHOUSE_PASS}@${host}/?query=select%20concat%28%27${CLICKHOUSE_CLUSTER_NAME}%27%2C%27.%27%2ChostName%28%29%2C%27.%27%2C%27metrics%27%2C%27.%27%2Cmetric%2C%27%20%27%2CtoString%28value%29%2C%27%20%27%2CtoString%28toUnixTimestamp%28now%28%29%29%29%29%20from%20system.metrics | nc ${GRAPHITE_HOST} ${GRAPHITE_PORT}
done
