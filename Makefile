-include env.mk

# Accept legacy build arguments during the image revision transition.
BASE_IMAGE_REVISION ?= $(BASE_IMAGE_STABILITY_TAG)

OPENSMTPD_VER ?= 7.8.0
OPENSMTPD_VER_MINOR := $(shell v='$(OPENSMTPD_VER)'; echo "$${v%.*}")

TAG ?= $(OPENSMTPD_VER_MINOR)

ALPINE_VER ?= 3.23

PLATFORM ?= linux/arm64

ifeq ($(BASE_IMAGE_REVISION),)
    BASE_IMAGE_TAG := $(ALPINE_VER)
else
    BASE_IMAGE_TAG := $(ALPINE_VER)-$(BASE_IMAGE_REVISION)
endif

REPO = wodby/opensmtpd
NAME = opensmtpd-$(OPENSMTPD_VER_MINOR)

ifneq ($(ARCH),)
	override TAG := $(TAG)-$(ARCH)
endif

.PHONY: build test push shell run start stop logs clean release

# Resolve the same pinned base image for every local and CI build target.
include base-images.mk

default: build

build:
	docker build --build-arg BASE_IMAGE="$(BASE_IMAGE)" -t $(REPO):$(TAG) \
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

# Keep CI scans aligned with the version, variant and architecture built by make.
.PHONY: image-ref
image-ref:
	@printf '%s\n' '$(REPO):$(TAG)'
