#!/bin/bash

docker pull nayanagamuhandiram/mysql_service
docker pull nayanagamuhandiram/jmeter_service
docker pull nayanagamuhandiram/adaptive-concurrency-control:latest

docker container kill db_Server jmeter_service initial_experiments some-redis tuner_service java_service adapt-t_service
docker container prune -f

docker network prune -f
docker network create --subnet=192.168.1.0/24 myNet

declare -a TestNameArray=("DbRead")
declare -a ConcurrencyPlanArray=("1_concurrency" "10_concurrency" "50_concurrency" "increase_and_decrease" "one_step_function" "random" "step_increase_fucntion" "up_down_function" "peaks")

for TestName in ${TestNameArray[*]}; do
  echo "$TestName"
  if [[ "$TestName" == "DbRead" ]]; then
    echo "im inside first if statement"
    docker run --publish 3306:3306 --name db_Server -d --net myNet --ip 192.168.1.6 --cpus=1 nayanagamuhandiram/mysql_service
    sleep 15
    docker run --publish 15000:15000 --name initial_experiments -d --net myNet --ip 192.168.1.4 --cpus=1 nayanagamuhandiram/adaptive-concurrency-control:initial_exp java -jar adaptive-concurrency-control-1.0-SNAPSHOT-jar-with-dependencies.jar DbWrite 10 99P
    docker run --name jmeter_service -d --net myNet --ip 192.168.1.5 --cpus=1 nayanagamuhandiram/jmeter_service java -jar bin/ApacheJMeter.jar -n -t 1_concurrency.jmx -q user.properties
    sleep 60
    docker container kill jmeter_service initial_experiments
    docker container prune -f
  fi
  for ConcurrencyPlan in ${ConcurrencyPlanArray[*]}; do
    echo "$ConcurrencyPlan"
    if [[ "$TestName" == "DbWrite" ]]; then
      echo "im inside second if statement"
      docker run --publish 3306:3306 --name db_Server -d --net myNet --ip 192.168.1.6 --cpus=1 nayanagamuhandiram/mysql_service
      sleep 1
    fi
    docker run --publish 15000:15000 --name adapt-t_service -d --net myNet --ip 192.168.1.4 --volume /home/nayananga/output/nilushan/"$TestName"/"$ConcurrencyPlan":/home/log --cpus=1 nayanagamuhandiram/adaptive-concurrency-control:latest java -jar adaptive-concurrency-control-1.0-SNAPSHOT-jar-with-dependencies.jar "$TestName" 10 99P
    docker run --name jmeter_service -d --net myNet --ip 192.168.1.5 --cpus=1 nayanagamuhandiram/jmeter_service java -jar bin/ApacheJMeter.jar -n -t "$ConcurrencyPlan".jmx -q user.properties
    sleep 1200
    docker container kill jmeter_service adapt-t_service
    if [[ "$TestName" == "DbWrite" ]]; then
      echo "im inside third if statement"
      docker container kill db_Server
    fi
    docker container prune -f
  done
done

exit
