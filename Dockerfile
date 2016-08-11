FROM alpine:3.4
MAINTAINER Wodby <admin@wodby.com>

RUN apk add --no-cache openssl ca-certificates opensmtpd

COPY smtpd.conf /etc/smtpd/

RUN mkdir -p /var/spool/smtpd
VOLUME /var/spool/smtpd
WORKDIR /var/spool/smtpd

EXPOSE 25

COPY docker-entrypoint.sh /usr/local/bin/
CMD "docker-entrypoint.sh"
