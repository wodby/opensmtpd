#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

chmod 711 /var/spool/smtpd

# The code of the file_env() function has been borrowed from
# https://github.com/ix-ai/smtp/blob/master/entrypoint.sh
# It is licensed under the MIT License, Copyright (c) 2018 Namshi
# usage: file_env VAR [DEFAULT]
#    ie: file_env 'XYZ_DB_PASSWORD' 'example'
# (will allow for "$XYZ_DB_PASSWORD_FILE" to fill in the value of
#  "$XYZ_DB_PASSWORD" from a file, especially for Docker's secrets feature)
file_env() {
	local var="$1"
	local fileVar="${var}_FILE"
	local def="${2:-}"
	if [ "${!var:-}" ] && [ "${!fileVar:-}" ]; then
		echo >&2 "error: both ${var} and ${fileVar} are set (but are mutually exclusive)"
		exit 1
	fi
	local val="$def"
	if [ "${!var:-}" ]; then
		val="${!var}"
	elif [ "${!fileVar:-}" ]; then
		val="$(< "${!fileVar}")"
	fi
	export "$var"="$val"
	unset "$fileVar"
}

# retrieve these 2 env vars from file, if any (typically used to deploy
# the password using docker secret)
file_env RELAY_USER
file_env RELAY_PASSWORD

gotpl /etc/gotpl/smtpd.conf.tmpl > /etc/smtpd/smtpd.conf

if [[ -n "${RELAY_USER}" ]]; then
    if [[ -n "${RELAY_PASSWORD}" ]]; then
        echo "user ${RELAY_USER}:${RELAY_PASSWORD}" > /etc/smtpd/authinfo
    else
        echo "user ${RELAY_USER}" > /etc/smtpd/authinfo
    fi

    makemap /etc/smtpd/authinfo
fi

if [[ "${1}" == 'make' ]]; then
    exec "${@}" -f /usr/local/bin/actions.mk
else
    exec "${@}"
fi
