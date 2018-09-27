# Pulumi: a CNAB base invocation image for Pulumi bundles

> [Pulumi][pulumi] is a Cloud Native Development Platform whose aim is to deliver Cloud Native Infrastructure as Code on any cloud with real programming languages and a consistent programming model.

This CNAB bundle provides a base image for working with Pulumi.

To test:

```bash
$ TODO
```

To use this as a base image:

```
FROM cnab/pulumi:latest

COPY my/pulumi/dir /cnab/app/pulumi
```

[pulumi]: https://www.pulumi.com/
