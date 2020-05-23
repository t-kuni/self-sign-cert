#!/bin/sh

echo "host: $HOST"
echo "ip: $IP"

envsubst < subjectnames-template.txt > subjectnames.txt

# Generate private key for CA and Server.
openssl genrsa 2048 > /out/server.key

# Generate certificate sigining requests from same key.
openssl req -new -key /out/server.key -subj "/C=AU/ST=Some-State/O=Self Sign Cert CA/CN=self-sign-cert.com" > /out/ca.csr
openssl req -new -key /out/server.key -subj "/C=AU/ST=Some-State/O=Self Sign Cert Server/CN=${HOST}" > /out/server.csr

# Generate CA certificate.
openssl ca -batch -extensions v3_ca -out /out/ca.crt -in /out/ca.csr -selfsign -keyfile /out/server.key

# Generate server certificate with CA certificate.
openssl x509 -days 3650 -req -extfile subjectnames.txt -CA /out/ca.crt -CAkey /out/server.key -set_serial 1 < /out/server.csr > /out/server.crt