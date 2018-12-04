# example-credentials

This bundle exhibits how to use credentials to pass confidential information into a bundle.

To build this demo, run the following commands from the root of the `bundles` repo:

```
$ BUNDLE=example-credentials make build
```

## Using This Bundle

Now change directories into this particular `example-credentials` sub-directory.

*Do not send real credentials into this bundle!* It simply echos them back to the console over the Docker socket.

Examine which credentials will be generated:

```console
$ duffle creds generate test_credentials -f ./bundle.cnab --dry-run
```

Generate a credential set and store it locally:

```console
$ duffle creds generate test_credentials -f ./bundle.cnab
```

Run the demo with the credential set:

```console
$ duffle install example-creds -f ./bundle.cnab -c test_credentials
Executing install action...

SECRET_ONE: credset secret 1
/var/secret_two/data.txt
credset secret 2
SECRET_THREE: credset secret 3
/var/secret_three/data.txt
credset secret 3
```