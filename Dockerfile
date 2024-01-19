# hadesarchitect/jenkins-inbound-agent-dind:linux-amd64
# docker buildx build --platform="linux/amd64" -t hadesarchitect/jenkins-inbound-agent-dind:linux-amd64 .
FROM jenkins/inbound-agent
USER root
RUN apt-get update && apt-get -y install docker.io bc
USER jenkins
