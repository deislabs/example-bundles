COMPOSE=/usr/local/bin/docker-compose

.PHONY: install
install:
	$(COMPOSE) up -d

.PHONY: upgrade
upgrade: install

.PHONY: uninstall
uninstall:
	$(COMPOSE) down

.PHONY: status
status:
	$(COMPOSE) ps
