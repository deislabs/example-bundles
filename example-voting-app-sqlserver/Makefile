VERSION ?= latest
REPO ?= cnab
IMG ?= example-voting-app-sqlserver

.PHONY: docker-build
docker-build:
	docker build -t $(REPO)/$(IMG):$(VERSION) .

.PHONY: docker-run
docker-run: docker-build
docker-run:
	docker run -t $(REPO)/$(IMG):$(VERSION)

.PHONY: docker-push
docker-push:
	docker push $(REPO)/$(IMG):$(VERSION)