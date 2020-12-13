# kafka-sasl-ssl
Kafka SASL SSL with multinode( 3 nodes of Zookeeper and Kafka) cluster setup without Kerberos.

Used the confluent images for cluster.

## Prerequisites 
### Software Installed
1. Docker
2. Docker Compose
3. Java

## Steps to create a cluster 
1. Create certificates 
    ```bash 
    $ cd secrets 
    $ ./create-certs.sh   
    ```
  **Note:- Enter yes untill certificates for all entity are generated.**

2.  Make the kafka SASL SSL Cluster up

    ```bash 
    $ cd ..
    $ ./kafka-sasl-ssl-cluster.sh up-daemon
    ```
      or 

    ```bash 
    $ cd ..
    $ ./kafka-sasl-ssl-cluster.sh up-logs
    ```
3. Make the kafka SASL SSL Cluster down
    ```bash 
    $ cd ..
    $ ./kafka-sasl-ssl-cluster.sh down
    ```


## Regenerate Certificates. 
 
    $ cd secrets
    $ ./delete-certs.sh
    $ ./create-certs.sh


## Reference
   [Kafka SASL SSL with Kerberos Setup.](https://docs.confluent.io/5.0.0/installation/docker/docs/installation/clustered-deployment-sasl.html) 
   

