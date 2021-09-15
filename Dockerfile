FROM openjdk:8-jdk-alpine
VOLUME /tmp
ARG JAR_FILE=target/devOpsDemo-0.0.1-SNAPSHOT.jar
COPY ${JAR_FILE} devOpsDemo-0.0.1-SNAPSHOT.jar
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Dserver.port=9096 -Djava.security.egd=file:/dev/./urandom -jar /devOpsDemo-0.0.1-SNAPSHOT.jar"]
