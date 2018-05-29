FROM maven:3-jdk-9-slim

RUN apt-get update && apt-get install -y git

WORKDIR /secor

ADD . /secor

RUN mvn verify --fail-never
RUN mvn package -DskipTests=true -Dmaven.javadoc.skip=true

FROM openjdk:9-jre-slim

RUN mkdir -p /opt/secor

COPY --from=0 /secor/target/secor-*-bin.tar.gz /opt/secor/

COPY src/main/scripts/docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
