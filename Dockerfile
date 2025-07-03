# Stage 1: Build the application using Maven
FROM maven:3.9.6-eclipse-temurin-17 AS build

WORKDIR /app

# Copy the project files
COPY . .

# Build the application
RUN mvn clean package -DskipTests

# Stage 2: Run the application using JRE
FROM eclipse-temurin:17-jre

WORKDIR /app

# Copy the built jar from the previous stage
COPY --from=build /app/target/profile-generator-1.3.jar app.jar

# Entry point to run the jar
ENTRYPOINT ["java", "-jar", "app.jar"]
