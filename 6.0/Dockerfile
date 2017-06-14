FROM alpine:3.6

ENV GOTLP_VER 0.1.5
ENV GOTPL_URL https://github.com/wodby/gotpl/releases/download/${GOTLP_VER}/gotpl-alpine-linux-amd64-${GOTLP_VER}.tar.gz

# @todo remove edge repos when mailutils will be added.
RUN echo '@edge http://alpine.gliderlabs.com/alpine/edge/main' >> /etc/apk/repositories && \
    echo '@testing http://alpine.gliderlabs.com/alpine/edge/testing' >> /etc/apk/repositories && \
    apk add --no-cache \
        bash@edge \
        ca-certificates \
        curl \
        libressl \
        readline@edge \
        mailutils@testing \
        make \
        opensmtpd \
        wget && \

    wget -qO- ${GOTPL_URL} | tar xz -C /usr/local/bin && \
    mkdir -p /var/spool/smtpd && touch /etc/smtpd/authinfo

VOLUME /var/spool/smtpd
WORKDIR /var/spool/smtpd

EXPOSE 25

COPY smtpd.conf.tpl /etc/gotpl/
COPY docker-entrypoint.sh /
COPY actions /usr/local/bin/

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["smtpd", "-d", "-P", "mda"]
