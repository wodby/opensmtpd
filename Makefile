-include env.mk

OPENSMTPD_VER = 6.0.3
OPENSMTPD_VER_MINOR := $(shell v='$(OPENSMTPD_VER)'; echo "$${v%.*}")

TAG ?= $(OPENSMTPD_VER_MINOR)

REPO = wodby/opensmtpd
NAME = opensmtpd-$(OPENSMTPD_VER_MINOR)

ifneq ($(STABILITY_TAG),)
    ifneq ($(TAG),latest)
        override TAG := $(TAG)-$(STABILITY_TAG)
    endif
endif

.PHONY: build test push shell run start stop logs clean release

default: build

build:
	docker build -t $(REPO):$(TAG) --build-arg OPENSMTPD_VER=$(OPENSMTPD_VER) ./

test:
	cd ./tests && ./run.sh $(NAME) $(REPO):$(TAG)

push:
	docker push $(REPO):$(TAG)

shell:
	docker run --rm --name $(NAME) -i -t $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(TAG) /bin/bash

run:
	docker run --rm --name $(NAME) $(LINKS) $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(TAG) $(CMD)

start:
	docker run -d --name $(NAME) $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(TAG)

stop:
	docker stop $(NAME)

logs:
	docker logs $(NAME)

clean:
	-docker rm -f $(NAME)

release: build push
