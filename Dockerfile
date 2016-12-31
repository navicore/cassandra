FROM cassandra:3.7
MAINTAINER ed@onextent.com

ENV REFRESHED_AT 2016-12-30

RUN apt-get -qq update && \
    DEBIAN_FRONTEND=noninteractive apt-get -yq install dnsutils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY k8s-entrypoint.sh /
ENTRYPOINT ["/k8s-entrypoint.sh"]
CMD ["cassandra", "-f"]

