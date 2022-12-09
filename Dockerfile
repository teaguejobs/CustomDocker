FROM jenkins/jenkins:lts-jdk11
COPY --chown=jenkins:jenkins plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt
USER root

RUN uname -a && cat /etc/*release

#install docker
RUN curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh

RUN apt-get update \
      && apt-get install -y sudo \
      && rm -rf /var/lib/apt/lists/*

RUN usermod -a -G root jenkins
RUN usermod -aG docker jenkins
# Good idea to switch back to the jenkins user.
USER jenkins