# check=skip=InvalidDefaultArgInFrom

# The Makefile supplies the required digest-pinned BASE_IMAGE argument.

ARG BASE_IMAGE
FROM ${BASE_IMAGE}

ARG OPENSMTPD_VER

ENV OPENSMTPD_VER="${OPENSMTPD_VER}"

# Keep rebuilds on the package revision selected for both architectures.
COPY .opensmtpd-package /tmp/.opensmtpd-package

RUN set -eux; \
    package_version="$(cat /tmp/.opensmtpd-package)"; \
    upstream_version="${package_version%-r*}"; \
    upstream_version="${upstream_version%_p*}"; \
    test "${upstream_version}" = "${OPENSMTPD_VER}"; \
    apk add --no-cache -t opensmtpd-rundeps \
        libressl \
        make \
        "opensmtpd=${package_version}"; \
    \
    rm /tmp/.opensmtpd-package; \
    mkdir -p /var/spool/smtpd

VOLUME /var/spool/smtpd
WORKDIR /var/spool/smtpd

EXPOSE 25

COPY templates /etc/gotpl/
COPY docker-entrypoint.sh /
COPY bin/ /usr/local/bin/

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["smtpd", "-dv"]
