#!/bin/bash
#
# Configure Cassandra seed nodes.

# Give Kubernetes time to add the new pod to the cassandra peer discovery service before we query DNS
sleep 5

#sed -i '/exec "$@"/i \java -jar plugin.jar' docker-entrypoint.sh
update-ca-certificates -f
#: ${CASSANDRA_CLUSTER_NAME:=Test Cluster}
#sed -ie "s/Test Cluster/${CASSANDRA_CLUSTER_NAME}/g" /config/plugin.json

my_ip=$(hostname --ip-address)

CASSANDRA_SEEDS=$(host $PEER_DISCOVERY_SERVICE | \
    grep -v "not found" | \
    grep -v "connection timed out" | \
    grep -v $my_ip | \
    sort | \
    head -3 | \
    awk '{print $4}' | \
    xargs)

if [ ! -z "$CASSANDRA_SEEDS" ]; then
    export CASSANDRA_SEEDS
fi

/docker-entrypoint.sh "$@"
