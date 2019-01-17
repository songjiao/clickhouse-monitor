# clickhouse-monitor
A tool collect clickhouse metrics and events to graphite

## How to use
* set clickhouse and graphite info in docker-compose.yaml
		
		
  environment:
          CLICKHOUSE_HOSTS: host1:8123,host2:8123
          CLICKHOUSE_USER: user1
          CLICKHOUSE_PASS: pass111
          CLICKHOUSE_CLUSTER_NAME: clickhouse.cluster1
          GRAPHITE_HOST: host3
          GRAPHITE_PORT: 2003
		
		
* start docker
		
		
		docker-compose up
		
		

## How it works
this tool use [ofelia](https://github.com/mcuadros/ofelia) to do job schedule  
job define in conf.ini
we defined a job execute monitor.sh every 10s  
monitor.sh read clickhouse hosts、user、password、graphite host info from ENV variables  
and select system.metric system.events from each clickhouse host and then use nc send result set to graphite

## Data visualization
just import dashboard.json into grafana
