FROM openjdk:8-jdk-alpine
COPY target/webappdemo.war app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
