#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

chmod 711 /var/spool/smtpd

gotpl "/etc/gotpl/smtpd.conf.tpl" > "/etc/smtpd/smtpd.conf"

if [[ -n "${RELAY_USER}" && -n "${RELAY_PASSWORD}" ]]; then
    echo "user ${RELAY_USER}:${RELAY_PASSWORD}" > /etc/smtpd/authinfo
    makemap /etc/smtpd/authinfo
fi

if [[ "${1}" == 'make' ]]; then
    exec "${@}" -f /usr/local/bin/actions.mk
else
    exec "${@}"
fi
