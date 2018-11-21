# Developer's Guide

## Bundle Development

### Docker Build

```shell
# builds the invocation image for the provided bundle
BUNDLE=<bundle> make docker-build

# builds invocation images for all bundles
make docker-build
```

### Docker Push

```shell
# pushes the invocation image for the provided bundle
BUNDLE=<bundle> make docker-push

# pushes invocation images for all bundles
make docker-push
```

### Sign Bundle(s)

This target currently requires and uses the `duffle` binary in one's path.

```shell
# signs the provided bundle
BUNDLE=<bundle> make sign

# signs all bundles
make sign
```

Note: the `sign-local` variant will output the signed bundle into each bundle's directory in the form of `bundle.cnab`.

### Docker Run

This command is only valid for a provided `BUNDLE`.

```shell
BUNDLE=<bundle> make docker-run
```

### Test Bundle(s)

#### Docker-based

This will run inside the latest `duffle` docker image.

```shell
# runs functional tests against the provided bundle
BUNDLE=<bundle> make test-functional-docker

# runs functional tests against all bundles
make test-functional-docker
```

#### Local

This will run using the local `duffle` binary found in one's path.

```shell
# runs functional tests against the provided bundle
BUNDLE=<bundle> make test-functional

# runs functional tests against all bundles
make test-functional
```
