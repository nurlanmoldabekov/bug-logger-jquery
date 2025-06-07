# Stage 1: Build WAR
FROM maven:3.9.6-eclipse-temurin-17 as builder

WORKDIR /app
COPY . .

RUN mvn clean package -DskipTests

FROM tomcat:9.0-jdk17
LABEL maintainer="nurlanmoldabekov"

# Remove default ROOT application
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy the WAR file to the Tomcat webapps directory
COPY target/ROOT.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]