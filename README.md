# Bet99 test project

### How to run the application locally
```
sudo docker compose up --build
```
the application will be available at:
http://localhost:8080/

### Alternative way to run the application locally
It's a back up way to run the app if the apps docker container is not running or the image wasn't built.
```
./mvnw clean spring-boot:run -Dspring-boot.run.arguments="--server.port=9090"
```
it still requires the MySQL container running. The application will be available at: 
http://localhost:9090/

### Dev notes
- The app packages into a single WAR file, which is deployed to a Tomcat server.
- The application is designed to be run in a Docker container for easy deployment and scalability.
- I didn't use any migration tool such as Flyway or Liquibase, but the database schema is created automatically by Hibernate.
- 

### The application screenshot
![Screenshot](screenshot.png)

