FROM maven:3.9.4-eclipse-temurin-17 AS builder
WORKDIR /build

# Copy only necessary files for a reproducible build
COPY pom.xml ./
COPY mvnw ./
COPY .mvn .mvn
COPY src ./src

# Use the included wrapper to build the jar
RUN ./mvnw -B -DskipTests package

FROM eclipse-temurin:17-jre
WORKDIR /app

# Copy built jar from builder stage
COPY --from=builder /build/target/*.jar app.jar

ENV JAVA_OPTS=""
EXPOSE 8002

ENTRYPOINT ["sh","-c","java $JAVA_OPTS -jar /app/app.jar"]
