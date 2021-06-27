#!/bin/bash

docker container kill db_Server nilushan_service jmeter_service
docker container prune -f

docker network prune -f
docker network create --subnet=192.168.1.0/24 myNet

## Spawn mysql db server
docker run --publish 3306:3306 --name db_Server -d --net myNet --ip 192.168.1.6 --cpus=1 nayanagamuhandiram/mysql_service

## Prime

##Concurrency 1
docker run --publish 15000:15000 --name nilushan_service -d --net myNet --ip 192.168.1.4 --volume /home/nayananga/output/nilushan/Prime1m_1:/home/log --cpus=1 nayanagamuhandiram/adaptive-concurrency-control java -jar adaptive-concurrency-control-1.0-SNAPSHOT-jar-with-dependencies.jar Prime1m 10 99P
docker run --name jmeter_service -d --net myNet --ip 192.168.1.5 --cpus=1 nayanagamuhandiram/jmeter_service java -jar bin/ApacheJMeter.jar -n -t 1_concurrency.jmx -q user.properties
sleep 1200
docker container kill jmeter_service nilushan_service
docker container prune -f

##Concurrency 10

docker run --publish 15000:15000 --name nilushan_service -d --net myNet --ip 192.168.1.4 --volume /home/nayananga/output/nilushan/Prime1m_10:/home/log --cpus=1 nayanagamuhandiram/adaptive-concurrency-control java -jar adaptive-concurrency-control-1.0-SNAPSHOT-jar-with-dependencies.jar Prime1m 10 99P
docker run --name jmeter_service -d --net myNet --ip 192.168.1.5 --cpus=1 nayanagamuhandiram/jmeter_service java -jar bin/ApacheJMeter.jar -n -t 10_concurrency.jmx -q user.properties
sleep 1200
docker container kill jmeter_service nilushan_service
docker container prune -f

##Concurrency 50

docker run --publish 15000:15000 --name nilushan_service -d --net myNet --ip 192.168.1.4 --volume /home/nayananga/output/nilushan/Prime1m_50:/home/log --cpus=1 nayanagamuhandiram/adaptive-concurrency-control java -jar adaptive-concurrency-control-1.0-SNAPSHOT-jar-with-dependencies.jar Prime1m 10 99P
docker run --name jmeter_service -d --net myNet --ip 192.168.1.5 --cpus=1 nayanagamuhandiram/jmeter_service java -jar bin/ApacheJMeter.jar -n -t 50_concurrency.jmx -q user.properties
sleep 1200
docker container kill jmeter_service nilushan_service
docker container prune -f

## DbWrite

##Concurrency 1
docker run --publish 15000:15000 --name nilushan_service -d --net myNet --ip 192.168.1.4 --volume /home/nayananga/output/nilushan/DbWrite_1:/home/log --cpus=1 nayanagamuhandiram/adaptive-concurrency-control java -jar adaptive-concurrency-control-1.0-SNAPSHOT-jar-with-dependencies.jar Prime1m 10 99P
docker run --name jmeter_service -d --net myNet --ip 192.168.1.5 --cpus=1 nayanagamuhandiram/jmeter_service java -jar bin/ApacheJMeter.jar -n -t 1_concurrency.jmx -q user.properties
sleep 1200
docker container kill jmeter_service nilushan_service
docker container prune -f

##Concurrency 10

docker run --publish 15000:15000 --name nilushan_service -d --net myNet --ip 192.168.1.4 --volume /home/nayananga/output/nilushan/DbWrite_10:/home/log --cpus=1 nayanagamuhandiram/adaptive-concurrency-control java -jar adaptive-concurrency-control-1.0-SNAPSHOT-jar-with-dependencies.jar Prime1m 10 99P
docker run --name jmeter_service -d --net myNet --ip 192.168.1.5 --cpus=1 nayanagamuhandiram/jmeter_service java -jar bin/ApacheJMeter.jar -n -t 10_concurrency.jmx -q user.properties
sleep 1200
docker container kill jmeter_service nilushan_service
docker container prune -f

##Concurrency 50

docker run --publish 15000:15000 --name nilushan_service -d --net myNet --ip 192.168.1.4 --volume /home/nayananga/output/nilushan/DbWrite_50:/home/log --cpus=1 nayanagamuhandiram/adaptive-concurrency-control java -jar adaptive-concurrency-control-1.0-SNAPSHOT-jar-with-dependencies.jar Prime1m 10 99P
docker run --name jmeter_service -d --net myNet --ip 192.168.1.5 --cpus=1 nayanagamuhandiram/jmeter_service java -jar bin/ApacheJMeter.jar -n -t 50_concurrency.jmx -q user.properties
sleep 1200
docker container kill jmeter_service nilushan_service
docker container prune -f

## DbRead

##Concurrency 1
docker run --publish 15000:15000 --name nilushan_service -d --net myNet --ip 192.168.1.4 --volume /home/nayananga/output/nilushan/DbRead_1:/home/log --cpus=1 nayanagamuhandiram/adaptive-concurrency-control java -jar adaptive-concurrency-control-1.0-SNAPSHOT-jar-with-dependencies.jar Prime1m 10 99P
docker run --name jmeter_service -d --net myNet --ip 192.168.1.5 --cpus=1 nayanagamuhandiram/jmeter_service java -jar bin/ApacheJMeter.jar -n -t 1_concurrency.jmx -q user.properties
sleep 1200
docker container kill jmeter_service nilushan_service
docker container prune -f

##Concurrency 10

docker run --publish 15000:15000 --name nilushan_service -d --net myNet --ip 192.168.1.4 --volume /home/nayananga/output/nilushan/DbRead_10:/home/log --cpus=1 nayanagamuhandiram/adaptive-concurrency-control java -jar adaptive-concurrency-control-1.0-SNAPSHOT-jar-with-dependencies.jar Prime1m 10 99P
docker run --name jmeter_service -d --net myNet --ip 192.168.1.5 --cpus=1 nayanagamuhandiram/jmeter_service java -jar bin/ApacheJMeter.jar -n -t 10_concurrency.jmx -q user.properties
sleep 1200
docker container kill jmeter_service nilushan_service
docker container prune -f

##Concurrency 50

docker run --publish 15000:15000 --name nilushan_service -d --net myNet --ip 192.168.1.4 --volume /home/nayananga/output/nilushan/DbRead_50:/home/log --cpus=1 nayanagamuhandiram/adaptive-concurrency-control java -jar adaptive-concurrency-control-1.0-SNAPSHOT-jar-with-dependencies.jar Prime1m 10 99P
docker run --name jmeter_service -d --net myNet --ip 192.168.1.5 --cpus=1 nayanagamuhandiram/jmeter_service java -jar bin/ApacheJMeter.jar -n -t 50_concurrency.jmx -q user.properties
sleep 1200
docker container kill jmeter_service nilushan_service
docker container prune -f

docker network prune -f
exit
