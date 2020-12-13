#!/bin/bash

set -o nounset \
    -o errexit \
    -o verbose \
    -o xtrace

# Generate CA key
openssl req -new -x509 -keyout snakeoil-ca-1.key -out snakeoil-ca-1.crt -days 365 -subj '/CN=ca1.piyushkumar96.github.io/OU=piyushkumar96/O=github/L=PaloAlto/S=Ca/C=US' -passin pass:temp@1234 -passout pass:temp@1234
# openssl req -new -x509 -keyout snakeoil-ca-2.key -out snakeoil-ca-2.crt -days 365 -subj '/CN=ca2.piyushkumar96.github.io/OU=piyushkumar96/O=github/L=PaloAlto/S=Ca/C=US' -passin pass:temp@1234 -passout pass:temp@1234

# Kafkacat
openssl genrsa -des3 -passout "pass:temp@1234" -out kafkacat.client.key 1024
openssl req -passin "pass:temp@1234" -passout "pass:temp@1234" -key kafkacat.client.key -new -out kafkacat.client.req -subj '/CN=kafkacat.piyushkumar96.github.io/OU=piyushkumar96/O=github/L=PaloAlto/S=Ca/C=US'
openssl x509 -req -CA snakeoil-ca-1.crt -CAkey snakeoil-ca-1.key -in kafkacat.client.req -out kafkacat-ca1-signed.pem -days 9999 -CAcreateserial -passin "pass:temp@1234"



for i in broker1 broker2 broker3 producer consumer
do
	echo $i
	# Create keystores
	keytool -genkey -noprompt \
				 -alias $i \
				 -dname "CN=$i.piyushkumar96.github.io, OU=piyushkumar96, O=github, L=PaloAlto, S=Ca, C=US" \
				 -keystore kafka.$i.keystore.jks \
				 -keyalg RSA \
				 -storepass temp@1234 \
				 -keypass temp@1234

	# Create CSR, sign the key and import back into keystore
	keytool -keystore kafka.$i.keystore.jks -alias $i -certreq -file $i.csr -storepass temp@1234 -keypass temp@1234

	openssl x509 -req -CA snakeoil-ca-1.crt -CAkey snakeoil-ca-1.key -in $i.csr -out $i-ca1-signed.crt -days 9999 -CAcreateserial -passin pass:temp@1234

	keytool -keystore kafka.$i.keystore.jks -alias CARoot -import -file snakeoil-ca-1.crt -storepass temp@1234 -keypass temp@1234

	keytool -keystore kafka.$i.keystore.jks -alias $i -import -file $i-ca1-signed.crt -storepass temp@1234 -keypass temp@1234

	# Create truststore and import the CA cert.
	keytool -keystore kafka.$i.truststore.jks -alias CARoot -import -file snakeoil-ca-1.crt -storepass temp@1234 -keypass temp@1234

  echo "temp@1234" > ${i}_sslkey_creds
  echo "temp@1234" > ${i}_keystore_creds
  echo "temp@1234" > ${i}_truststore_creds
done
