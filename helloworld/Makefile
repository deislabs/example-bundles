VERSION ?= 0.1.1
REPO ?= cnab
IMG ?= helloworld

.PHONY: docker-build
docker-build:
	cd cnab && docker build -t $(REPO)/$(IMG):$(VERSION) .

.PHONY: docker-run
docker-run: docker-build
docker-run:
	docker run -t $(REPO)/$(IMG):$(VERSION)