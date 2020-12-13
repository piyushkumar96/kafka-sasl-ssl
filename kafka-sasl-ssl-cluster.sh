#!/bin/bash


source "./script-utils/scriptUtils.sh"
source "./script-utils/checkPreRequisites.sh"
#set -x

case $1 in

  up-daemon)
    export KAFKA_SASL_SECRETS_DIR=$(pwd)/secrets
    docker-compose -f docker-compose.yml up -d
  ;;

  up-logs)
    export KAFKA_SASL_SECRETS_DIR=$(pwd)/secrets
    docker-compose -f docker-compose.yml up
  ;;

  down)
    docker-compose -f docker-compose.yml down
    ;;

  *)
    infoln "Usage:"
    infoln "    1. To up the cluster as daemon process run cmd:-
        kafka-sasl-ssl-cluster.sh up-daemon \n
    2. To up the cluster with logging run cmd:-
        kafka-sasl-ssl-cluster.sh up-logs \n
    3. To stop the cluster run cmd:- 
        kafka-sasl-ssl-cluster.sh down \n"
    ;;
esac