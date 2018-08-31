#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
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
opensmtpd smtpd -h 2>&1 | grep -q "OpenSMTPD 6.0.*"
echo "OK"

echo -n "Validating OpenSMTPD config... "
opensmtpd smtpd -n 2>&1 | grep -q "configuration OK"
echo "OK"
