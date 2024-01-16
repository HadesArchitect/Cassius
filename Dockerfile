FROM jenkins/inbound-agent
USER root
RUN apt-get update && apt-get -y install docker.io
USER jenkins
