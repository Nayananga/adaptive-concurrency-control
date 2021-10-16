#!/bin/bash

docker pull nayanagamuhandiram/mysql_service
docker pull nayanagamuhandiram/jmeter_service
docker pull nayanagamuhandiram/java_service
docker pull nayanagamuhandiram/python_service:hpc_testing_5
docker pull nayanagamuhandiram/python_service:hpc_testing_4
docker pull nayanagamuhandiram/python_service:hpc_testing_3

docker container kill db_Server some-redis tuner java_service jmeter_service
docker container prune -f

docker network prune -f
docker network create --subnet=192.168.1.0/24 myNet

## Spawn mysql db server
#docker run --publish 3306:3306 --name db_Server -d --net myNet --ip 192.168.1.6 --cpus=1 nayanagamuhandiram/mysql_service

#Prime

#isuru

##Concurrency 1

docker run --publish 6379:6379 --name some-redis -d --net myNet --ip 192.168.1.2 --cpus=1 redis
docker run --publish 5000:5000 --name tuner -d --net myNet --ip 192.168.1.3 --volume /home/nayananga/output/isuru/python/Prime1m_1:/app/Data/ACTUAL --cpus=1 nayanagamuhandiram/python_service:hpc_testing_3  python app.py Prime1m_1
docker run --publish 15000:15000 --name java_service -d --net myNet --ip 192.168.1.4 --volume /home/nayananga/output/isuru/java/Prime1m_1:/home/log --cpus=1 nayanagamuhandiram/java_service java -jar adaptive-concurrency-control-1.0-SNAPSHOT-jar-with-dependencies.jar Prime1m 10 99P
docker run --name jmeter_service -d --net myNet --ip 192.168.1.5 --volume /home/nayananga/jmeter_results/isuru:/opt/apache-jmeter-5.2.1/jmeter_results --cpus=1 nayanagamuhandiram/jmeter_service java -jar bin/ApacheJMeter.jar -n -t 1_concurrency.jmx -q user.properties -l /opt/apache-jmeter-5.2.1/jmeter_results/Prime1m_1.jtl
sleep 1200
docker container kill jmeter_service
sleep 120
docker container kill some-redis tuner java_service
docker container prune -f

##Concurrency 10

docker run --publish 6379:6379 --name some-redis -d --net myNet --ip 192.168.1.2 --cpus=1 redis
docker run --publish 5000:5000 --name tuner -d --net myNet --ip 192.168.1.3 --volume /home/nayananga/output/isuru/python/Prime1m_10:/app/Data/ACTUAL --cpus=1 nayanagamuhandiram/python_service:hpc_testing_3  python app.py Prime1m_10
docker run --publish 15000:15000 --name java_service -d --net myNet --ip 192.168.1.4 --volume /home/nayananga/output/isuru/java/Prime1m_10:/home/log --cpus=1 nayanagamuhandiram/java_service java -jar adaptive-concurrency-control-1.0-SNAPSHOT-jar-with-dependencies.jar Prime1m 10 99P
docker run --name jmeter_service -d --net myNet --ip 192.168.1.5 --volume /home/nayananga/jmeter_results/isuru:/opt/apache-jmeter-5.2.1/jmeter_results --cpus=1 nayanagamuhandiram/jmeter_service java -jar bin/ApacheJMeter.jar -n -t 10_concurrency.jmx -q user.properties -l /opt/apache-jmeter-5.2.1/jmeter_results/Prime1m_10.jtl
sleep 1200
docker container kill jmeter_service
sleep 120
docker container kill some-redis tuner java_service
docker container prune -f

##Concurrency 50

docker run --publish 6379:6379 --name some-redis -d --net myNet --ip 192.168.1.2 --cpus=1 redis
docker run --publish 5000:5000 --name tuner -d --net myNet --ip 192.168.1.3 --volume /home/nayananga/output/isuru/python/Prime1m_50:/app/Data/ACTUAL --cpus=1 nayanagamuhandiram/python_service:hpc_testing_3  python app.py Prime1m_50
docker run --publish 15000:15000 --name java_service -d --net myNet --ip 192.168.1.4 --volume /home/nayananga/output/isuru/java/Prime1m_50:/home/log --cpus=1 nayanagamuhandiram/java_service java -jar adaptive-concurrency-control-1.0-SNAPSHOT-jar-with-dependencies.jar Prime1m 10 99P
docker run --name jmeter_service -d --net myNet --ip 192.168.1.5 --volume /home/nayananga/jmeter_results/isuru:/opt/apache-jmeter-5.2.1/jmeter_results --cpus=1 nayanagamuhandiram/jmeter_service java -jar bin/ApacheJMeter.jar -n -t 50_concurrency.jmx -q user.properties -l /opt/apache-jmeter-5.2.1/jmeter_results/Prime1m_50.jtl
sleep 1200
docker container kill jmeter_service
sleep 120
docker container kill some-redis tuner java_service
docker container prune -f


#increase_and_decrease

docker run --publish 6379:6379 --name some-redis -d --net myNet --ip 192.168.1.2 --cpus=1 redis
docker run --publish 5000:5000 --name tuner -d --net myNet --ip 192.168.1.3 --volume /home/nayananga/output/isuru/python/increase_and_decrease:/app/Data/ACTUAL --cpus=1 nayanagamuhandiram/python_service:hpc_testing_3  python app.py increase_and_decrease
docker run --publish 15000:15000 --name java_service -d --net myNet --ip 192.168.1.4 --volume /home/nayananga/output/isuru/java/increase_and_decrease:/home/log --cpus=1 nayanagamuhandiram/java_service java -jar adaptive-concurrency-control-1.0-SNAPSHOT-jar-with-dependencies.jar Prime1m 10 99P
docker run --name jmeter_service -d --net myNet --ip 192.168.1.5 --volume /home/nayananga/jmeter_results/isuru:/opt/apache-jmeter-5.2.1/jmeter_results --cpus=1 nayanagamuhandiram/jmeter_service java -jar bin/ApacheJMeter.jar -n -t increase_and_decrease.jmx -q user.properties -l /opt/apache-jmeter-5.2.1/jmeter_results/increase_and_decrease.jtl
sleep 1200
docker container kill jmeter_service
sleep 120
docker container kill some-redis tuner java_service
docker container prune -f

#one_step_function

docker run --publish 6379:6379 --name some-redis -d --net myNet --ip 192.168.1.2 --cpus=1 redis
docker run --publish 5000:5000 --name tuner -d --net myNet --ip 192.168.1.3 --volume /home/nayananga/output/isuru/python/one_step_function:/app/Data/ACTUAL --cpus=1 nayanagamuhandiram/python_service:hpc_testing_3  python app.py one_step_function
docker run --publish 15000:15000 --name java_service -d --net myNet --ip 192.168.1.4 --volume /home/nayananga/output/isuru/java/one_step_function:/home/log --cpus=1 nayanagamuhandiram/java_service java -jar adaptive-concurrency-control-1.0-SNAPSHOT-jar-with-dependencies.jar Prime1m 10 99P
docker run --name jmeter_service -d --net myNet --ip 192.168.1.5 --volume /home/nayananga/jmeter_results/isuru:/opt/apache-jmeter-5.2.1/jmeter_results --cpus=1 nayanagamuhandiram/jmeter_service java -jar bin/ApacheJMeter.jar -n -t one_step_function.jmx -q user.properties -l /opt/apache-jmeter-5.2.1/jmeter_results/one_step_function.jtl
sleep 1200
docker container kill jmeter_service
sleep 120
docker container kill some-redis tuner java_service
docker container prune -f

#random

docker run --publish 6379:6379 --name some-redis -d --net myNet --ip 192.168.1.2 --cpus=1 redis
docker run --publish 5000:5000 --name tuner -d --net myNet --ip 192.168.1.3 --volume /home/nayananga/output/isuru/python/random:/app/Data/ACTUAL --cpus=1 nayanagamuhandiram/python_service:hpc_testing_3  python app.py random
docker run --publish 15000:15000 --name java_service -d --net myNet --ip 192.168.1.4 --volume /home/nayananga/output/isuru/java/random:/home/log --cpus=1 nayanagamuhandiram/java_service java -jar adaptive-concurrency-control-1.0-SNAPSHOT-jar-with-dependencies.jar Prime1m 10 99P
docker run --name jmeter_service -d --net myNet --ip 192.168.1.5 --volume /home/nayananga/jmeter_results/isuru:/opt/apache-jmeter-5.2.1/jmeter_results --cpus=1 nayanagamuhandiram/jmeter_service java -jar bin/ApacheJMeter.jar -n -t random.jmx -q user.properties -l /opt/apache-jmeter-5.2.1/jmeter_results/random.jtl
sleep 1200
docker container kill jmeter_service
sleep 120
docker container kill some-redis tuner java_service
docker container prune -f

#step_increase_fucntion
docker pull nayanagamuhandiram/python_service:hpc_testing_3
docker run --publish 6379:6379 --name some-redis -d --net myNet --ip 192.168.1.2 --cpus=1 redis
docker run --publish 5000:5000 --name tuner -d --net myNet --ip 192.168.1.3 --volume /home/nayananga/output/isuru/python/step_increase_fucntion:/app/Data/ACTUAL --cpus=1 nayanagamuhandiram/python_service:hpc_testing_3  python app.py step_increase_function
docker run --publish 15000:15000 --name java_service -d --net myNet --ip 192.168.1.4 --volume /home/nayananga/output/isuru/java/step_increase_fucntion:/home/log --cpus=1 nayanagamuhandiram/java_service java -jar adaptive-concurrency-control-1.0-SNAPSHOT-jar-with-dependencies.jar Prime1m 10 99P
docker run --name jmeter_service -d --net myNet --ip 192.168.1.5 --volume /home/nayananga/jmeter_results/isuru:/opt/apache-jmeter-5.2.1/jmeter_results --cpus=1 nayanagamuhandiram/jmeter_service java -jar bin/ApacheJMeter.jar -n -t step_increase_fucntion.jmx -q user.properties -l /opt/apache-jmeter-5.2.1/jmeter_results/step_increase_function.jtl
sleep 1200
docker container kill jmeter_service
sleep 120
docker container kill some-redis tuner java_service
docker container prune -f

#up_down_function

docker run --publish 6379:6379 --name some-redis -d --net myNet --ip 192.168.1.2 --cpus=1 redis
docker run --publish 5000:5000 --name tuner -d --net myNet --ip 192.168.1.3 --volume /home/nayananga/output/isuru/python/up_down_function:/app/Data/ACTUAL --cpus=1 nayanagamuhandiram/python_service:hpc_testing_3  python app.py up_down_function
docker run --publish 15000:15000 --name java_service -d --net myNet --ip 192.168.1.4 --volume /home/nayananga/output/isuru/java/up_down_function:/home/log --cpus=1 nayanagamuhandiram/java_service java -jar adaptive-concurrency-control-1.0-SNAPSHOT-jar-with-dependencies.jar Prime1m 10 99P
docker run --name jmeter_service -d --net myNet --ip 192.168.1.5 --volume /home/nayananga/jmeter_results/isuru:/opt/apache-jmeter-5.2.1/jmeter_results --cpus=1 nayanagamuhandiram/jmeter_service java -jar bin/ApacheJMeter.jar -n -t up_down_function.jmx -q user.properties -l /opt/apache-jmeter-5.2.1/jmeter_results/up_down_function.jtl
sleep 1200
docker container kill jmeter_service
sleep 120
docker container kill some-redis tuner java_service
docker container prune -f

#peaks

docker run --publish 6379:6379 --name some-redis -d --net myNet --ip 192.168.1.2 --cpus=1 redis
docker run --publish 5000:5000 --name tuner -d --net myNet --ip 192.168.1.3 --volume /home/nayananga/output/isuru/python/peaks:/app/Data/ACTUAL --cpus=1 nayanagamuhandiram/python_service:hpc_testing_3  python app.py peaks
docker run --publish 15000:15000 --name java_service -d --net myNet --ip 192.168.1.4 --volume /home/nayananga/output/isuru/java/peaks:/home/log --cpus=1 nayanagamuhandiram/java_service java -jar adaptive-concurrency-control-1.0-SNAPSHOT-jar-with-dependencies.jar Prime1m 10 99P
docker run --name jmeter_service -d --net myNet --ip 192.168.1.5 --volume /home/nayananga/jmeter_results/isuru:/opt/apache-jmeter-5.2.1/jmeter_results --cpus=1 nayanagamuhandiram/jmeter_service java -jar bin/ApacheJMeter.jar -n -t peaks.jmx -q user.properties -l /opt/apache-jmeter-5.2.1/jmeter_results/peaks.jtl
sleep 1200
docker container kill jmeter_service
sleep 120
docker container kill some-redis tuner java_service
docker container prune -f

docker container kill db_Server nilushan_service jmeter_service
docker container prune -f

docker network prune -f
docker network create --subnet=192.168.1.0/24 myNet

## Spawn mysql db server
#docker run --publish 3306:3306 --name db_Server -d --net myNet --ip 192.168.1.6 --cpus=1 nayanagamuhandiram/mysql_service

## Prime

#nilushan

##Concurrency 1

docker run --publish 15000:15000 --name nilushan_service -d --net myNet --ip 192.168.1.4 --volume /home/nayananga/output/nilushan/Prime1m_1:/home/log --cpus=1 nayanagamuhandiram/adaptive-concurrency-control java -jar adaptive-concurrency-control-1.0-SNAPSHOT-jar-with-dependencies.jar Prime1m 10 99P
docker run --name jmeter_service -d --net myNet --ip 192.168.1.5 --volume /home/nayananga/jmeter_results/nilushan:/opt/apache-jmeter-5.2.1/jmeter_results --cpus=1 nayanagamuhandiram/jmeter_service java -jar bin/ApacheJMeter.jar -n -t 1_concurrency.jmx -q user.properties -l /opt/apache-jmeter-5.2.1/jmeter_results/Prime1m_1.jtl
sleep 1200
docker container kill jmeter_service nilushan_service
docker container prune -f

##Concurrency 10

docker run --publish 15000:15000 --name nilushan_service -d --net myNet --ip 192.168.1.4 --volume /home/nayananga/output/nilushan/Prime1m_10:/home/log --cpus=1 nayanagamuhandiram/adaptive-concurrency-control java -jar adaptive-concurrency-control-1.0-SNAPSHOT-jar-with-dependencies.jar Prime1m 10 99P
docker run --name jmeter_service -d --net myNet --ip 192.168.1.5 --volume /home/nayananga/jmeter_results/nilushan:/opt/apache-jmeter-5.2.1/jmeter_results --cpus=1 nayanagamuhandiram/jmeter_service java -jar bin/ApacheJMeter.jar -n -t 10_concurrency.jmx -q user.properties -l /opt/apache-jmeter-5.2.1/jmeter_results/Prime1m_10.jtl
sleep 1200
docker container kill jmeter_service nilushan_service
docker container prune -f

##Concurrency 50

docker run --publish 15000:15000 --name nilushan_service -d --net myNet --ip 192.168.1.4 --volume /home/nayananga/output/nilushan/Prime1m_50:/home/log --cpus=1 nayanagamuhandiram/adaptive-concurrency-control java -jar adaptive-concurrency-control-1.0-SNAPSHOT-jar-with-dependencies.jar Prime1m 10 99P
docker run --name jmeter_service -d --net myNet --ip 192.168.1.5 --volume /home/nayananga/jmeter_results/nilushan:/opt/apache-jmeter-5.2.1/jmeter_results --cpus=1 nayanagamuhandiram/jmeter_service java -jar bin/ApacheJMeter.jar -n -t 50_concurrency.jmx -q user.properties -l /opt/apache-jmeter-5.2.1/jmeter_results/Prime1m_50.jtl
sleep 1200
docker container kill jmeter_service nilushan_service
docker container prune -f

#increase_and_decrease

docker run --publish 15000:15000 --name nilushan_service -d --net myNet --ip 192.168.1.4 --volume /home/nayananga/output/nilushan/increase_and_decrease:/home/log --cpus=1 nayanagamuhandiram/adaptive-concurrency-control java -jar adaptive-concurrency-control-1.0-SNAPSHOT-jar-with-dependencies.jar Prime1m 10 99P
docker run --name jmeter_service -d --net myNet --ip 192.168.1.5 --volume /home/nayananga/jmeter_results/nilushan:/opt/apache-jmeter-5.2.1/jmeter_results --cpus=1 nayanagamuhandiram/jmeter_service java -jar bin/ApacheJMeter.jar -n -t increase_and_decrease.jmx -q user.properties -l /opt/apache-jmeter-5.2.1/jmeter_results/increase_and_decrease.jtl
sleep 1200
docker container kill jmeter_service nilushan_service
docker container prune -f

#one_step_function

docker run --publish 15000:15000 --name nilushan_service -d --net myNet --ip 192.168.1.4 --volume /home/nayananga/output/nilushan/one_step_function:/home/log --cpus=1 nayanagamuhandiram/adaptive-concurrency-control java -jar adaptive-concurrency-control-1.0-SNAPSHOT-jar-with-dependencies.jar Prime1m 10 99P
docker run --name jmeter_service -d --net myNet --ip 192.168.1.5 --volume /home/nayananga/jmeter_results/nilushan:/opt/apache-jmeter-5.2.1/jmeter_results --cpus=1 nayanagamuhandiram/jmeter_service java -jar bin/ApacheJMeter.jar -n -t one_step_function.jmx -q user.properties -l /opt/apache-jmeter-5.2.1/jmeter_results/one_step_function.jtl
sleep 1200
docker container kill jmeter_service nilushan_service
docker container prune -f

#random

docker run --publish 15000:15000 --name nilushan_service -d --net myNet --ip 192.168.1.4 --volume /home/nayananga/output/nilushan/random:/home/log --cpus=1 nayanagamuhandiram/adaptive-concurrency-control java -jar adaptive-concurrency-control-1.0-SNAPSHOT-jar-with-dependencies.jar Prime1m 10 99P
docker run --name jmeter_service -d --net myNet --ip 192.168.1.5 --volume /home/nayananga/jmeter_results/nilushan:/opt/apache-jmeter-5.2.1/jmeter_results --cpus=1 nayanagamuhandiram/jmeter_service java -jar bin/ApacheJMeter.jar -n -t random.jmx -q user.properties -l /opt/apache-jmeter-5.2.1/jmeter_results/random.jtl
sleep 1200
docker container kill jmeter_service nilushan_service
docker container prune -f

#step_increase_fucntion

docker run --publish 15000:15000 --name nilushan_service -d --net myNet --ip 192.168.1.4 --volume /home/nayananga/output/nilushan/step_increase_fucntion:/home/log --cpus=1 nayanagamuhandiram/adaptive-concurrency-control java -jar adaptive-concurrency-control-1.0-SNAPSHOT-jar-with-dependencies.jar Prime1m 10 99P
docker run --name jmeter_service -d --net myNet --ip 192.168.1.5 --volume /home/nayananga/jmeter_results/nilushan:/opt/apache-jmeter-5.2.1/jmeter_results --cpus=1 nayanagamuhandiram/jmeter_service java -jar bin/ApacheJMeter.jar -n -t step_increase_fucntion.jmx -q user.properties -l /opt/apache-jmeter-5.2.1/jmeter_results/step_increase_function.jtl
sleep 1200
docker container kill jmeter_service nilushan_service
docker container prune -f

#up_down_function

docker run --publish 15000:15000 --name nilushan_service -d --net myNet --ip 192.168.1.4 --volume /home/nayananga/output/nilushan/up_down_function:/home/log --cpus=1 nayanagamuhandiram/adaptive-concurrency-control java -jar adaptive-concurrency-control-1.0-SNAPSHOT-jar-with-dependencies.jar Prime1m 10 99P
docker run --name jmeter_service -d --net myNet --ip 192.168.1.5 --volume /home/nayananga/jmeter_results/nilushan:/opt/apache-jmeter-5.2.1/jmeter_results --cpus=1 nayanagamuhandiram/jmeter_service java -jar bin/ApacheJMeter.jar -n -t up_down_function.jmx -q user.properties -l /opt/apache-jmeter-5.2.1/jmeter_results/up_down_function.jtl
sleep 1200
docker container kill jmeter_service nilushan_service
docker container prune -f

#peaks

docker run --publish 15000:15000 --name nilushan_service -d --net myNet --ip 192.168.1.4 --volume /home/nayananga/output/nilushan/peaks:/home/log --cpus=1 nayanagamuhandiram/adaptive-concurrency-control java -jar adaptive-concurrency-control-1.0-SNAPSHOT-jar-with-dependencies.jar Prime1m 10 99P
docker run --name jmeter_service -d --net myNet --ip 192.168.1.5 --volume /home/nayananga/jmeter_results/nilushan:/opt/apache-jmeter-5.2.1/jmeter_results --cpus=1 nayanagamuhandiram/jmeter_service java -jar bin/ApacheJMeter.jar -n -t peaks.jmx -q user.properties -l /opt/apache-jmeter-5.2.1/jmeter_results/peaks.jtl
sleep 1200
docker container kill jmeter_service nilushan_service
docker container prune -f

exit