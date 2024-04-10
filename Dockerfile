# Use a previous build as a cache source
FROM openjdk:17-jdk-slim-buster AS TEMP_BUILD_IMAGE

# Copy only necessary dependency files for caching purposes
WORKDIR /usr/app
COPY gradle gradle
COPY build.gradle.kts settings.gradle.kts gradlew .editorconfig ./

# Copy the source and build it
COPY src src
RUN ./gradlew ktlintFormat build -x test

# Final stage
FROM openjdk:17-jdk-slim-buster
ENV ARTIFACT_NAME=demo.jar
ENV APP_HOME=/usr/app/
WORKDIR $APP_HOME
COPY --from=TEMP_BUILD_IMAGE $APP_HOME/build/libs/$ARTIFACT_NAME .

EXPOSE 8080
ENTRYPOINT java -jar $ARTIFACT_NAME
