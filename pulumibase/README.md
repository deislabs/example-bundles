# Pulumi: a CNAB base invocation image for Pulumi bundles

> [Pulumi][pulumi] is a Cloud Native Development Platform whose aim is to deliver Cloud Native Infrastructure as Code on any cloud with real programming languages and a consistent programming model.

This CNAB bundle provides a base image for working with Pulumi.
To use this as a base image:

```
FROM cnab/pulumibase:latest

COPY my/pulumi/dir /cnab/app/pulumi
```

This bundle creates a new deployment in an existing Kubernetes cluster. To pass the Kubernetes config file, use a Duffle credential set:

```yaml
name: pulumi
credentials:
- destination:
    path: /root/.kube/config
  name: kubeconfig
  source:
    path: $HOME/.kube/config
```

[pulumi]: https://www.pulumi.com/
