VERSION ?= latest
REPO ?= cnab
IMG ?= ansible-azurevm

.PHONY: docker-build
docker-build:
	docker build -t $(REPO)/$(IMG):$(VERSION) .

.PHONY: docker-run
docker-run: docker-build
docker-run:
	docker run -t $(REPO)/$(IMG):$(VERSION)