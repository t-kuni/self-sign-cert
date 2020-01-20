FROM alpine:3.10.1
RUN apk --no-cache add openssl gettext

COPY src /src
WORKDIR /src

CMD ["./gen.sh"]