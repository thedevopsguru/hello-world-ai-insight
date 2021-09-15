# Build
FROM maven:3.6.0-jdk-11-slim AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

# Package
FROM openjdk:8-jdk-alpine
COPY --from=build /home/app/target/devOpsDemo-0.0.1-SNAPSHOT.jar /usr/local/lib/devOpsDemo.jar
ENTRYPOINT ["java","-jar","/usr/local/lib/devOpsDemo.jar"]
EXPOSE 2222
