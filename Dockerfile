# Pull base image
FROM maven:latest

# Install nginx and adjust nginx config to stay in foreground
COPY . .
RUN ls
RUN mvn clean install
# Expose HTTP
EXPOSE 9080

# Start 
ENTRYPOINT [ "mvn", "spring-boot:run" ]
