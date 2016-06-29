FROM jenkins:latest

USER root

VOLUME /var/lib/docker

RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

RUN echo "deb http://apt.dockerproject.org/repo debian-jessie main" > /etc/apt/sources.list.d/docker.list

RUN apt-get update && \
  apt-get -y install \
    docker-engine

# RUN install-plugins.sh git 

# COPY plugins /usr/share/jenkins/plugins

# RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins

ENTRYPOINT ["java", "-jar", "/usr/share/jenkins/jenkins.war"]
