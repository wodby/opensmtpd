-include env.mk

OPENSMTPD_VER ?= 7.6.0
OPENSMTPD_VER_MINOR := $(shell v='$(OPENSMTPD_VER)'; echo "$${v%.*}")

TAG ?= $(OPENSMTPD_VER_MINOR)

ALPINE_VER ?= 3.21

PLATFORM ?= linux/arm64

ifeq ($(BASE_IMAGE_STABILITY_TAG),)
    BASE_IMAGE_TAG := $(ALPINE_VER)
else
    BASE_IMAGE_TAG := $(ALPINE_VER)-$(BASE_IMAGE_STABILITY_TAG)
endif

REPO = wodby/opensmtpd
NAME = opensmtpd-$(OPENSMTPD_VER_MINOR)

ifneq ($(ARCH),)
	override TAG := $(TAG)-$(ARCH)
endif

.PHONY: build test push shell run start stop logs clean release

default: build

build:
	docker build -t $(REPO):$(TAG) \
		--build-arg BASE_IMAGE_TAG=$(BASE_IMAGE_TAG) \
		--build-arg OPENSMTPD_VER=$(OPENSMTPD_VER) ./

buildx-imagetools-create:
	docker buildx imagetools create -t $(REPO):$(TAG) \
				$(REPO):$(OPENSMTPD_VER_MINOR)-amd64 \
				$(REPO):$(OPENSMTPD_VER_MINOR)-arm64
.PHONY: buildx-imagetools-create

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
