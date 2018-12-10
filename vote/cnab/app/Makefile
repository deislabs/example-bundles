CNAB_ACTION ?= status
CNAB_INSTALLATION_NAME ?= vote
CNAB_P_NAMESPACE ?= vote
CNAB_P_HELM_OPTIONS ?= 

install:
	@echo "Do $(CNAB_ACTION) for $(CNAB_INSTALLATION_NAME)"
	@for chart in $$(ls charts); do [[ ! -d charts/$$chart ]] || \
		helm install --namespace $(CNAB_P_NAMESPACE) $(CNAB_P_HELM_OPTIONS)  -n $(CNAB_INSTALLATION_NAME)-$$chart ./charts/$$chart ;\
	done
	@echo All charts installed

uninstall: 
	@echo "Do Uninstall"
	@for chart in $$(ls charts); do [[ ! -d charts/$$chart ]] || \
		helm delete --purge $(CNAB_INSTALLATION_NAME)-$$chart $(CNAB_P_HELM_OPTIONS) ;\
	done

upgrade:
	@echo "Do Upgrade"
	@for chart in $$(ls charts); do [[ ! -d charts/$$chart ]] || \
		helm upgrade --namespace $(CNAB_P_NAMESPACE) $(CNAB_INSTALLATION_NAME)-$$chart charts/$$chart $(CNAB_P_HELM_OPTIONS) ;\
	done

status:
	@echo "Do Status"
	@for chart in $$(ls charts); do [[ ! -d charts/$$chart ]] || \
		helm status  $(CNAB_INSTALLATION_NAME)-$$chart ;\
	done

.PHONY: install uninstall upgrade status