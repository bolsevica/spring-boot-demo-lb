FROM openjdk:8-jdk-alpine
COPY target/webappdemo.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
