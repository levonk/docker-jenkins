# Identify Jenkins versions here https://hub.docker.com/r/library/jenkins/tags/
FROM jenkins:2.19.3
MAINTAINER Levon Karayan

ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000

ENV JAVA_OPTS="-Dfile.encoding=UTF-8 -Dclient.encoding.override=UTF-8 -Djava.net.preferIPv4Stack=true -server -XX:+HeapDumpOnOutOfMemoryError -XX:-PrintClassHistogram -XX:+PrintConcurrentLocks -XX:+PrintCommandLineFlags -XX:+PreserveFramePointer -XX:-CMSClassUnloadingEnabled -XX:CMSInitiatingOccupancyFraction=90 -XX:MaxHeapFreeRation=90"

USER root
RUN mkdir -p /var/log/jenkins && chown -R ${user}:${group} /var/log/jenkins
RUN mkdir -p /var/cache/jenkins && chown -R ${user}:${group} /var/cache/jenkins
USER ${user}

ENV JENKINS_OPTS="--handlerCountStartup=10 --handlerCountMax=30 --logfile=/var/log/jenkins/jenkins.log"

COPY plugins.txt ${JENKINS_HOME}/.
RUN plugins.sh plugins.txt
