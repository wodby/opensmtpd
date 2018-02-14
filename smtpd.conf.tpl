listen on 0.0.0.0

table aliases file:/etc/smtpd/aliases

# Specify how long a message can stay in the queue. The default value is 4 days.
expire {{ getenv "OPENSMTPD_EXPIRE" "4d" }}

# Specify the delays for which temporary failure reports must be generated
# when messages are stuck in the queue.
bounce-warn {{ getenv "OPENSMTPD_BOUNCE_WARN" "1h, 6h, 2d" }}

# Specify a maximum message size of n bytes.
# The argument may contain a multiplier, as documented in scan_scaled(3).
# The default maximum message size is 35MB if none is specified.
max-message-size {{ getenv "OPENSMTPD_MAX_MESSAGE_SIZE" "35M" }}

# smtpd(8) accepts and rejects messages based on information gathered during
# the SMTP session.
# For each message processed by the daemon, the filter rules are evaluated
# in sequential order, from first to last. The first matching rule decides
# what action is taken. If no rule matches the message, the default action
# is to reject the message.

{{ if getenv "RELAY_HOST" }}
{{ if getenv "RELAY_USER" }}
table authinfo db:/etc/smtpd/authinfo.db
accept from any for any relay via "tls+auth://user@{{ getenv "RELAY_HOST" }}:{{ getenv "RELAY_PORT" "587" }}" auth <authinfo>
{{ else }}
accept from any for any relay via "tls://{{ getenv "RELAY_HOST" }}:{{ getenv "RELAY_PORT" "587" }}"
{{ end }}
{{ else }}
accept from any for any relay
{{ end }}