#!/bin/sh

echo $HOST
echo $IP

envsubst < subjectnames-template.txt > subjectnames.txt
openssl genrsa 2048 > ./out/server.key
openssl req -new -key ./out/server.key -subj "/C=AU/ST=Some-State/O=Internet Widgits Pty Ltd/CN=${HOST}" > ./out/server.csr
openssl x509 -days 3650 -req -extfile subjectnames.txt -signkey ./out/server.key < ./out/server.csr > ./out/server.crt
rm subjectnames.txt