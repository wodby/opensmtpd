.PHONY: check-ready check-live

host ?= localhost
max_try ?= 1
wait_seconds ?= 1
delay_seconds ?= 0
command = { echo 'quit'; sleep 1; } | telnet ${host} 25 | grep -q 220 &> /dev/null
service = OpenSMPTD

default: check-ready

check-ready:
	wait-for.sh "$(command)" $(service) $(host) $(max_try) $(wait_seconds) $(delay_seconds)

check-live:
	@echo "OK"
