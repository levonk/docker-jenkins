# Identify Jenkins versions here https://hub.docker.com/r/library/jenkins/tags/
FROM jenkins:2.19.3
MAINTAINER Levon Karayan

ENV JENKINS_HOME /var/jenkins_home

ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000

ENV JAVA_OPTS="-Xmx2048m -Xms1024m -Djava.awt.headless=true -Dfile.encoding=UTF-8 -Dclient.encoding.override=UTF-8 -Djava.net.preferIPv4Stack=true -XX:+HeapDumpOnOutOfMemoryError -XX:-PrintClassHistogram -XX:+PrintConcurrentLocks -XX:+PrintCommandLineFlags -XX:+PreserveFramePointer -XX:-CMSClassUnloadingEnabled -XX:CMSInitiatingOccupancyFraction=90 -XX:MaxHeapFreeRatio=90 -server"

#ENV JENKINS_OPTS="--handlerCountStartup=20 --handlerCountMax=40 --logfile=/var/log/jenkins/jenkins.log"
ENV JENKINS_OPTS="--handlerCountMax=100 --logfile=/var/log/jenkins/jenkins.log"

USER root
RUN mkdir -p /var/log/jenkins; chown -R ${user}:${group} /var/log/jenkins
RUN mkdir -p /var/cache/jenkins; chown -R ${user}:${group} /var/cache/jenkins
USER ${user}


RUN install-plugins.sh git:3.0.0
RUN install-plugins.sh github:1.22.3
RUN install-plugins.sh github-api:1.79
RUN install-plugins.sh google-login:1.2.1
