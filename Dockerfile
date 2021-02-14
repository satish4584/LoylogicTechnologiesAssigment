FROM ubuntu:16.04
RUN apt-get update && \
    apt-get install -y curl \
    wget \
    openjdk-8-jdk
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java
RUN echo "export PATH=$JAVA_HOME/bin:$PATH" >> /root/.bashrc
WORKDIR /mnt/artefact
COPY target target
CMD ["java","-jar","/mnt/artefact/target/*.jar"]