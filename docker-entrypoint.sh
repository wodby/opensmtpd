#!/bin/sh

set -eo pipefail

chmod 711 /var/spool/smtpd

exec smtpd -d -P mda
