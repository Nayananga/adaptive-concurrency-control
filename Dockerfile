FROM openjdk:8

WORKDIR /home

COPY target/adaptive-concurrency-control-1.0-SNAPSHOT-jar-with-dependencies.jar .

RUN mkdir log

EXPOSE 15000
