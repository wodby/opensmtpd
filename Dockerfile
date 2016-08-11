FROM alpine:3.4
MAINTAINER Wodby <admin@wodby.com>

RUN apk add --no-cache openssl ca-certificates opensmtpd

COPY smtpd.conf /etc/smtpd/

RUN mkdir -p /var/spool/smtpd && chmod 711 /var/spool/smtpd
VOLUME /var/spool/smtpd
WORKDIR /var/spool/smtpd

EXPOSE 25

CMD ["smtpd", "-d", "-P", "mda"]
