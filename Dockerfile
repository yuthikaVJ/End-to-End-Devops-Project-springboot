FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app
COPY target/BLE-ERP-Backend.jar app.jar
EXPOSE 5000
ENTRYPOINT ["java", "-jar", "app.jar"]