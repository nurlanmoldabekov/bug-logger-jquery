# Dockerfile
FROM maven:3.8.6-eclipse-temurin-17 AS build
WORKDIR /build
# Copy pom and cache dependencies
COPY pom.xml .
RUN mvn dependency:go-offline
# Copy sources and build WAR
COPY src/ ./src/
RUN mvn clean package -DskipTests

FROM tomcat:10.1-jdk17
# Remove default ROOT webapp
RUN rm -rf /usr/local/tomcat/webapps/ROOT*
# Copy WAR (must be named ROOT.war)
COPY --from=build /build/target/ROOT.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]