FROM openjdk:8-stretch
LABEL maintainer="vouu <contact@4da.site>" version="9.1.0"
ARG JIRA_VERSION=5.1.0
# Production: jira-software jira-core
ARG JIRA_PRODUCT=crowd
ARG AGENT_VERSION=1
ARG MYSQL_DRIVER_VERSION=5.1.48
ENV JIRA_USER=jira \
    JIRA_GROUP=jira \
    JIRA_HOME=/var/jira \
    JIRA_INSTALL=/opt/jira \
    JVM_MINIMUM_MEMORY=1g \
    JVM_MAXIMUM_MEMORY=3g \
    JVM_CODE_CACHE_ARGS='-XX:InitialCodeCacheSize=1g -XX:ReservedCodeCacheSize=2g' \
    AGENT_PATH=/var/agent \
    AGENT_FILENAME=atlassian-agent.jar
ENV JAVA_OPTS="-javaagent:${AGENT_PATH}/${AGENT_FILENAME} ${JAVA_OPTS}"
RUN mkdir -p ${JIRA_INSTALL} ${JIRA_HOME} ${AGENT_PATH} \
&& curl -o /tmp/atlassian.tar.gz https://product-downloads.atlassian.com/software/crowd/downloads/atlassian-${JIRA_PRODUCT}-${JIRA_VERSION}.tar.gz -L \
&& tar xzf /tmp/atlassian.tar.gz -C ${JIRA_INSTALL}/ --strip-components 1 \
&& rm -f /tmp/atlassian.tar.gz \
&& curl -o ${JIRA_INSTALL}/apache-tomcat/lib/mysql-connector-java-${MYSQL_DRIVER_VERSION}.jar https://repo1.maven.org/maven2/mysql/mysql-connector-java/${MYSQL_DRIVER_VERSION}/mysql-connector-java-${MYSQL_DRIVER_VERSION}.jar -L \
&& echo "crowd.home = ${JIRA_HOME}" > ${JIRA_INSTALL}/crowd-webapp/WEB-INF/classes/crowd-init.properties
ADD agent.jar /var/agent/atlassian-agent.jar
RUN export CONTAINER_USER=$JIRA_USER \
&& export CONTAINER_GROUP=$JIRA_GROUP \
&& groupadd -r $JIRA_GROUP && useradd -r -g $JIRA_GROUP $JIRA_USER \
&& chown -R $JIRA_USER:$JIRA_GROUP ${JIRA_INSTALL} ${JIRA_HOME}/ ${AGENT_PATH}
VOLUME $JIRA_HOME
USER $JIRA_USER
WORKDIR $JIRA_INSTALL
EXPOSE 8443
ENTRYPOINT ["/opt/jira/start_crowd.sh", "-fg"]