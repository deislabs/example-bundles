# Developer's Guide

## Bundle Development

### Docker Build

```shell
BUNDLE=<bundle> make docker-build
```

### Docker Push

```shell
BUNDLE=<bundle> make docker-push
```

### Docker Run

```shell
BUNDLE=<bundle> make docker-run
```

### Test Bundle

```shell
BUNDLE=<bundle> make test-functional
```

## All Bundles

### Build all Docker Images

```shell
make docker-build-all
```

### Push all Docker Images

```shell
make docker-push-all
```

## Test all Bundles

```shell
make test-functional-all
```