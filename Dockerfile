# Maven build container 

FROM maven:3.5.2-jdk-8-alpine AS maven_build

COPY pom.xml /tmp/

COPY src /tmp/src/

WORKDIR /tmp/

RUN mvn package

#pull base image

FROM openjdk:8-jdk-alpine

#maintainer 
MAINTAINER odasari@miraclesoft.com
#expose port 8080
EXPOSE 8080

#default command
CMD java -jar /MSS-User-Auth-0.0.1-SNAPSHOT.jar

#copy hello world to docker image from builder image
COPY --from=maven_build /tmp/target/MSS-User-Auth-0.0.1-SNAPSHOT.jar /data/MSS-User-Auth-0.0.1-SNAPSHOT.jar
