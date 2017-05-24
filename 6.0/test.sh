#!/usr/bin/env bash

set -e

if [[ ! -z "${DEBUG}" ]]; then
    set -x
fi

name=$1
image=$2

cid="$(docker run -d --name "${name}" "${image}")"
trap "docker rm -vf $cid > /dev/null" EXIT

opensmtpd() {
	docker run --rm -i --link "${name}" "${image}" "${@}"
}

echo -n "Waiting for OpenSMTPD to start... "
opensmtpd make check-ready host="${name}" max_try=10
echo "OK"

echo -n "Checking OpenSMTPD version... "
# Ignore exit code 1.
! opensmtpd smtpd -h | grep -q "OpenSMTPD 6.0.*"
echo "OK"