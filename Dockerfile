FROM wodby/alpine:3.8-2.1.0

ARG OPENSMTPD_VER

ENV OPENSMTPD_VER="${OPENSMTPD_VER}"

RUN apk add --no-cache -t opensmtpd-rundeps \
        libressl \
        make \
        "opensmtpd~${OPENSMTPD_VER}"; \
    \
    mkdir -p /var/spool/smtpd

VOLUME /var/spool/smtpd
WORKDIR /var/spool/smtpd

EXPOSE 25

COPY templates /etc/gotpl/
COPY docker-entrypoint.sh /
COPY bin/ /usr/local/bin/

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["smtpd", "-dv"]
