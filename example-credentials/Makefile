VERSION ?= 0.1.0
REPO ?= cnab
IMG ?= example-credentials

.PHONY: build
build: docker-build
build:
	duffle key sign bundle.json

.PHONY: docker-build
docker-build:
	cd cnab && docker build -t $(REPO)/$(IMG):$(VERSION) .

.PHONY: docker-run
docker-run: docker-build
docker-run:
	docker run -t $(REPO)/$(IMG):$(VERSION)