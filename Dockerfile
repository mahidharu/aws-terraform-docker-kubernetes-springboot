FROM openjdk:8-jdk-alpine
RUN addgroup -S docker && adduser -S ec2-user -G ec2-user
USER ec2-user:ec2-user
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar","/app.jar"]