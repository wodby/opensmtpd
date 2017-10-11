FROM wodby/alpine:3.6-1.0.0

ARG OPENSMTPD_VER

ENV OPENSMTPD_VER_ALPINE="${OPENSMTPD_VER}p1-r2"

RUN apk add --no-cache \
        libressl \
        make \
        opensmtpd=${OPENSMTPD_VER_ALPINE} && \

    mkdir -p /var/spool/smtpd

VOLUME /var/spool/smtpd
WORKDIR /var/spool/smtpd

EXPOSE 25

COPY smtpd.conf.tpl /etc/gotpl/
COPY docker-entrypoint.sh /
COPY actions /usr/local/bin/

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["smtpd", "-dv"]
