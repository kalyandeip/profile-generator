# Stage 1: Build using Maven
FROM maven:3.9.6-eclipse-temurin-17 AS builder

# Set working directory
WORKDIR /app

# Copy all project files
COPY . .

# Package the application (skip tests if needed)
RUN mvn clean package -DskipTests

# Stage 2: Create a minimal runtime image
FROM eclipse-temurin:17-jre

# Set working directory in the container
WORKDIR /app

# Copy the JAR file from the previous build stage
COPY --from=builder /app/target/profile-generator-1.3.jar app.jar

# Command to run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
