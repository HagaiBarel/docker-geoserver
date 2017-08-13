#!/bin/bash

export INSTANCE_NAME=$HOSTNAME
export CLUSTER_CONFIG_DIR=${GEOSERVER_DATA_DIR}/cluster/${INSTANCE_NAME}
export JAVA_OPTS='-DCLUSTER_CONFIG_DIR=$CLUSTER_CONFIG_DIR -Dactivemq.base=$CLUSTER_CONFIG_DIR/tmp -Dactivemq.transportConnectors.server.uri=tcp://127.0.0.1:9545'

/bin/bash -c "catalina.sh run"