PROJECT         := bundles
ORG             := deislabs
DOCKER_REGISTRY ?= cnab

BASE_DIR        := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

GIT             ?= git
GIT_TAG         := $(shell $(GIT) describe --tags --always)
VERSION         ?= ${GIT_TAG}
# Replace + with -, for Docker image tag compliance
IMAGE_TAG       ?= $(subst +,-,$(VERSION))
BUNDLE          ?=
DUFFLE_IMG      ?= deislabs/duffle:latest

# --no-print-directory avoids verbose cd logging when invoking targets that utilize sub-makes
MAKE_OPTS       ?= --no-print-directory

ifeq ($(OS),Windows_NT)
	SHELL  = cmd.exe
	CHECK  = where.exe
else
	SHELL  ?= bash
	CHECK  ?= command -v
endif

HAS_DOCKER := $(shell $(CHECK) docker)
HAS_DUFFLE := $(shell $(CHECK) duffle)

.PHONY: has-docker
has-docker:
ifndef HAS_DOCKER
	$(error You must install docker)
endif

.PHONY: has-duffle
has-duffle:
ifndef HAS_DUFFLE
	$(error You must install duffle)
endif

# all loops through all sub-directories and if the file provided by the first argument exists,
# it will run the make target(s) provided by the second argument
define all
	@for dir in $$(ls -1); do \
		if [[ -e "$$dir/$(1)" ]]; then \
			BUNDLE=$$dir make $(MAKE_OPTS) $(2) ; \
		fi ; \
	done
endef

# run the provided make target on all bundles with a 'cnab/Dockerfile' file in their directory
define docker-all
	$(call all,cnab/Dockerfile,$(1))
endef

# run the provided make target on all bundles with a 'bundle.json' file in their directory
define bundle-all
	$(call all,bundle.json,$(1))
endef

.PHONY: check-bundle
check-bundle:
ifndef BUNDLE
	$(error BUNDLE must be provided, e.g., BUNDLE=<bundle> make <target>)
endif

.PHONY: build
build: docker-build

.PHONY: docker-build
docker-build:
ifndef BUNDLE
	$(call docker-all,docker-build)
else 
	docker build -t $(DOCKER_REGISTRY)/$(BUNDLE):$(IMAGE_TAG) $(BUNDLE)/cnab
endif

.PHONY: docker-push
docker-push:
ifndef BUNDLE
	$(call docker-all,docker-push)
else
	docker push $(DOCKER_REGISTRY)/$(BUNDLE):$(IMAGE_TAG)
endif

.PHONY: docker-run
docker-run: check-bundle
	docker run -t $(DOCKER_REGISTRY)/$(BUNDLE):$(VERSION)

JSON_SCHEMA_URI  := https://api.github.com/repos/deislabs/cnab-spec/contents/schema/bundle.schema.json
JSON_SCHEMA_FILE := /tmp/bundle.schema.json
VALIDATOR_IMG    := $(ORG)/$(PROJECT)-ajv
VALIDATOR_CMD    := ajv test -s $(JSON_SCHEMA_FILE) -d $(BUNDLE)/bundle.json --valid

.PHONY: build-validator
build-validator:
	@docker build -f Dockerfile.ajv \
		--build-arg json_schema_uri=$(JSON_SCHEMA_URI) \
		--build-arg json_schema_file=$(JSON_SCHEMA_FILE) \
		-t $(VALIDATOR_IMG) .

.PHONY: validate
validate:
ifndef BUNDLE
	$(call bundle-all,validate)
else
	@docker run --rm \
		-v ${BASE_DIR}:/root \
		-w /root \
		-e BUNDLE=$(BUNDLE) \
		$(VALIDATOR_IMG) sh -c '$(VALIDATOR_CMD)'
endif

.PHONY: build-validator-local
build-validator-local:
	@npm install -g ajv-cli
	@wget -q \
		--header 'Accept: application/vnd.github.v3.raw' \
		-O $(JSON_SCHEMA_FILE) \
		$(JSON_SCHEMA_URI)

.PHONY: validate-local
validate-local:
ifndef BUNDLE
	$(call bundle-all,validate-local)
else
	@$(VALIDATOR_CMD)
endif

## Functional test flags/values

# duffle commands will run in insecure mode if this is 'true'
INSECURE     ?= false
# duffle will export a thick bundle (vs thin) if this is 'true'
EXPORT_THICK ?= false
# duffle commands will run with the driver set by DRIVER
DRIVER       ?= debug

.PHONY: test-functional
test-functional:
	DRIVER=$(DRIVER) ./scripts/test-functional.sh

.PHONY: test-functional-docker
test-functional-docker:
	@docker pull $(DUFFLE_IMG)
	@docker run --rm \
		-v ${BASE_DIR}:/src \
		-w /src \
		-e GIT=":" \
		-e BUNDLE=$(BUNDLE) \
		-e INSECURE=$(INSECURE) \
		-e DRIVER=$(DRIVER) \
		-e EXPORT_THCK=$(EXPORT_THICK) \
		-e CHECK=which \
		$(DUFFLE_IMG) sh -c 'make $(MAKE_OPTS) test-functional'

.PHONY: clean
clean:
ifndef BUNDLE
	$(call bundle-all,clean)
else
	rm -f $(BUNDLE)/bundle.cnab
endif
