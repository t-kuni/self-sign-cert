FROM alpine:3.10.1
RUN apk --no-cache add openssl gettext


#COPY ./subjectnames.txt /root/certs/subjectnames.txt
#
#RUN apk --no-cache add openssl
#RUN cd /root/certs \
#    && openssl genrsa 2048 > server.key \
#    && openssl req -new -key server.key -subj "/C=AU/ST=Some-State/O=Internet Widgits Pty Ltd/CN=example.com" > server.csr \
#    && openssl x509 -days 3650 -req -extfile subjectnames.txt -signkey server.key < server.csr > server.crt
#
#FROM nginx:1.14.2-alpine
#COPY --from=base /root/certs /etc/nginx/conf.d/certs
#
#RUN apk --no-cache add gettext




WORKDIR /work

CMD ["./gen.sh"]