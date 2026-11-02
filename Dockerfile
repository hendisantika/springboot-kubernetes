FROM amazoncorretto:25-alpine-jdk AS build

WORKDIR /project

# Resolve dependencies first to leverage Docker layer caching
COPY .mvn .mvn
COPY mvnw pom.xml ./
RUN chmod +x mvnw && ./mvnw -B -q dependency:go-offline

COPY src src

# Passed from Github Actions
ARG GIT_VERSION_TAG=unspecified
ARG GIT_COMMIT_MESSAGE=unspecified
ARG GIT_VERSION_HASH=unspecified

# You can read these files for the information in your application
RUN echo $GIT_VERSION_TAG > GIT_VERSION_TAG.txt
RUN echo $GIT_COMMIT_MESSAGE > GIT_COMMIT_MESSAGE.txt
RUN echo $GIT_VERSION_HASH > GIT_VERSION_HASH.txt

RUN ./mvnw -B clean package -DskipTests

FROM amazoncorretto:25-alpine-jdk
LABEL maintainer="hendisantika@yahoo.co.id"

RUN addgroup -g 1001 -S hendigroup && adduser -S hendi -u 1001 -G hendigroup

WORKDIR /app

COPY --from=build --chown=hendi:hendigroup /project/target/springboot-k8s-0.0.1.jar /app/app.jar

USER hendi

EXPOSE 8080

ENTRYPOINT ["sh", "-c", "exec java $JAVA_OPTS -jar /app/app.jar"]
