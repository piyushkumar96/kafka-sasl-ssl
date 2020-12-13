#!/bin/bash

find .  -maxdepth 1 -type f ! -name "broker1_jaas.conf" ! -name "broker2_jaas.conf" ! -name "broker3_jaas.conf" ! -name "consumer_jaas.conf" ! -name "create-certs.sh" ! -name "delete-certs.sh" ! -name "host.consumer.ssl.config" ! -name "host.consumer.ssl.sasl.config" ! -name "host.producer.ssl.config" ! -name "host.producer.ssl.sasl.config" ! -name "producer_jaas.conf" ! -name "zookeeper_1_jaas.conf" ! -name "zookeeper_2_jaas.conf" ! -name "zookeeper_3_jaas.conf" -delete
 
