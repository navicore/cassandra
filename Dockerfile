FROM cassandra:3.7
MAINTAINER ed@onextent.com

ENV REFRESHED_AT 2016-12-30

RUN apt-get -qq update && \
    DEBIAN_FRONTEND=noninteractive apt-get -yq install dnsutils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY newrelic /etc/cassandra/newrelic
COPY conf/cassandra-env.sh /etc/cassandra/cassandra-env.sh

COPY k8s-entrypoint.sh /

#CMD /k8s-entrypoint.sh cassandra -f && sleep 1m && java -jar plugin.jar

ENTRYPOINT ["/k8s-entrypoint.sh"]
CMD ["cassandra", "-f"]
