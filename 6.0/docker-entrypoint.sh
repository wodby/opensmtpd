#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

chmod 711 /var/spool/smtpd

gotpl "/etc/gotpl/smtpd.conf.tpl" > "/etc/smtpd/smtpd.conf"

if [[ -n "${SENDGRID_USERNAME}" && -n "${SENDGRID_PASSWORD}" ]]; then
    echo "${SENDGRID_USERNAME} ${SENDGRID_PASSWORD}" > /etc/smtpd/authinfo
fi

if [[ "${1}" == 'make' ]]; then
    exec "${@}" -f /usr/local/bin/actions.mk
else
    exec "${@}"
fi
