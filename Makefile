.PHONY: plugin release

VERSION ?= latest

DOCKER_OWNER=lowess
DOCKER_IMAGE=drone-ansible

plugin:
	@echo "Building Drone plugin (export VERSION=<version> if needed)"
	docker build . -t $(DOCKER_OWNER)/$(DOCKER_IMAGE):$(VERSION)

release:
	@echo "Pushing Drone plugin to the registry"
	docker push $(DOCKER_OWNER)/$(DOCKER_IMAGE):$(VERSION)
