# example-voting-app-sqlserver

This bundle contains a docker compose-based voting app.

To build this demo, run the following commands from the root of the `bundles` repo:

```
$ export BUNDLE=example-voting-app-sqlserver
$ make docker-build
$ make sign-local
```

## Using This Bundle

To execute this bundle, run the following from this `example-voting-app-sqlserver` directory:

```console
$ duffle install -f ./bundle.cnab example-voting-app-sqlserver
```