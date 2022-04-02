# Production Dockerfile
FROM maven:3.8.1-jdk-11 AS builder
WORKDIR /app
COPY ./ /app
RUN mvn clean compile package
RUN ls /app/target/demo.jar

FROM adoptopenjdk/openjdk11:alpine-jre
COPY --from=builder /app/target/demo.jar app.jar
#ADD ./src/main/resources/front /usr/local/iorb/
ENTRYPOINT ["java","-jar","app.jar"]
