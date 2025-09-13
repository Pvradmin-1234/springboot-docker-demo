# Use official OpenJDK 17 runtime as base image
FROM openjdk:17-jdk-slim

# Set metadata
LABEL maintainer="devops-team@company.com"
LABEL version="1.0"
LABEL description="Docker image for Jenkins-built Java application"

# Set working directory
WORKDIR /app

# Create a non-root user for security
RUN groupadd -r appgroup && useradd -r -g appgroup appuser
RUN chown -R appuser:appgroup /app
USER appuser

# Copy the JAR file built by Maven
COPY --chown=appuser:appgroup target/*.jar app.jar

# Expose the application port
EXPOSE 8080

# Set environment variables for Java 17
ENV JAVA_OPTS="-Xmx512m -Xms256m --add-opens java.base/java.lang=ALL-UNNAMED"
ENV SPRING_PROFILES_ACTIVE="docker"

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=60s --retries=3 \
  CMD curl -f http://localhost:8080/health || exit 1

# Run the application
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
