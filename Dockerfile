#FROM adoptopenjdk/openjdk11:alpine-jre
#FROM openjdk:21-jdk
FROM bellsoft/liberica-openjdk-debian:21
LABEL maintainer="hendisantika@yahoo.co.id"
# Refer to Maven build -> finalName
#ARG JAR_FILE=target/springboot-kubernetes-0.0.1-SNAPSHOT.jar
# cd /opt/app
#WORKDIR /opt/app
RUN mkdir /app
COPY --from=build /project/target/springboot-k8s-0.0.1.jar /app/app.jar

WORKDIR /app

# cp target/spring-boot-web.jar /opt/app/app.jar
COPY ${JAR_FILE} app.jar

VOLUME /tmp
EXPOSE 8080
ADD target/springboot-k8s-0.0.1.jar app.jar
ENTRYPOINT ["java","-jar","app.jar"]
