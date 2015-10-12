FROM ariya/centos7-oracle-jre7

RUN yum -y install tar curl wget
# Get and install teamcity
RUN curl -L https://download.jetbrains.com/teamcity/TeamCity-9.1.3.tar.gz | tar -xz -C /opt

# Enable the correct Valve when running behind a proxy
RUN sed -i -e "s/\.*<\/Host>.*$/<Valve className=\"org.apache.catalina.valves.RemoteIpValve\" protocolHeader=\"x-forwarded-proto\" \/><\/Host>/" /opt/TeamCity/conf/server.xml

ENV TEAMCITY_DATA_PATH /data/teamcity

COPY entry.sh /entry.sh

ENTRYPOINT ["/entry.sh"]

VOLUME /data/teamcity
EXPOSE  8111
