DOCKER=/usr/local/bin/docker

.PHONY: install
install:
	@echo "Basic Auth: ${CNAB_P_BASIC_AUTH}"
	$(DOCKER) stack deploy func --compose-file docker-compose.yml

.PHONY: upgrade
upgrade: install

.PHONY: uninstall
uninstall:
	$(DOCKER) stack rm func

.PHONY: status
status:
	$(DOCKER) stack ps func
