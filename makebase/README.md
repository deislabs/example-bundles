# Makebase: A make-centered base invocation image

This is a base invocation image that provides Make as a core service.

Rather than write a custom `run` tool, this image lets you write a
`Makefile` that looks like this:

```Makefile
CNAB_ACTION ?= "status"

install:
	@echo "Do Install"
	@echo $(CNAB_ACTION)

uninstall: 
	@echo "Do Uninstall"

upgrade:
	@echo "Do Upgrade"

status:
	@echo "Do Status"

.PHONY: install uninstall upgrade status
```

The `Makefile` should be placed in `/cnab/app`:

```Dockerfile
FROM cnab/makebase:latest
COPY Makefile /cnab/app/Makefile
COPY Dockerfile /cnab/Dockerfile
```

Note that this base image has no properties or credentials that you need to account for.