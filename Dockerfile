FROM openjdk:8-jdk-alpine
ARG JAR_FILE=target/rest-service-0.0.1-SNAPSHOT.jar
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar","/rest-service-0.0.1.jar"]