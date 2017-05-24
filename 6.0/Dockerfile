FROM alpine:3.5

ENV GOTLP_VER 0.1.5
ENV GOTPL_URL https://github.com/wodby/gotpl/releases/download/${GOTLP_VER}/gotpl-alpine-linux-amd64-${GOTLP_VER}.tar.gz

RUN echo '@edge http://alpine.gliderlabs.com/alpine/edge/main' >> /etc/apk/repositories && \
    apk add --no-cache \
        bash \
        ca-certificates \
        curl \
        libressl \
        make \
        opensmtpd@edge \
        wget && \

    wget -qO- ${GOTPL_URL} | tar xz -C /usr/local/bin

COPY smtpd.conf.tpl /etc/gotpl/

RUN mkdir -p /var/spool/smtpd
VOLUME /var/spool/smtpd
WORKDIR /var/spool/smtpd

EXPOSE 25

COPY docker-entrypoint.sh /
COPY actions /usr/local/bin/

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["smtpd", "-d", "-P", "mda"]
