#FROM adoptopenjdk/openjdk11:alpine-jre
FROM openjdk:11
LABEL maintainer="hendisantika@yahoo.co.id"
# Refer to Maven build -> finalName
#ARG JAR_FILE=target/springboot-kubernetes-0.0.1-SNAPSHOT.jar
# cd /opt/app
#WORKDIR /opt/app

# cp target/spring-boot-web.jar /opt/app/app.jar
COPY ${JAR_FILE} app.jar

VOLUME /tmp
EXPOSE 8080
ADD target/springboot-kubernetes-0.0.1.jar app.jar
ENTRYPOINT ["java","-jar","app.jar"]