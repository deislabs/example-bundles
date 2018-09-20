# Wordpress Bundle for Kubernetes
### "The hello world of the cloud"

This bundle downloads and configures helm and installs wordpress (stable/wordpress) into a Kubernetes cluster and connects it to an external database.

## Prerequistes
- Running Kubernetes cluster (we used AKS)
- External mysql database server (we used Azure MySQL)
  - Take note of the db host address
  - Create a database called bitnami_wordpress
    - To connect to your database, you'll want to create a Firewall rule to allow access from your IP([docs](https://docs.microsoft.com/en-us/azure/mysql/concepts-firewall-rules)). Azure MySQL makes this easy. In the Azure portal for your MySQL instance:
    1. Go to "Connection Security"
    2. Click "Add Client IP" which adds a firewall rule using your IP
    3. Enjoy your fancy new firewall rule by connecting to your db in the regular fashion
  - Configure with a database user and credentials ([docs](https://docs.microsoft.com/en-us/azure/mysql/howto-create-users))
  - If you're on Azure, you can "Allow access to Azure services" by toggling that option "ON".([docs](https://docs.microsoft.com/en-us/azure/mysql/concepts-firewall-rules#connecting-from-azure))
  - If you're not connecting from an Azure service to your Azure database, then you might have to configure SSL ([docs](https://docs.microsoft.com/en-us/azure/mysql/concepts-ssl-connection-security)). The other option is opening up your database to connections from the world which I highly recommend not doing because security is a thing and we've all learned lessons this year about not securing data properly.

## Install this bundle
1. Clone this repo: `git clone git@github.com:deis/bundles.git`
2. `cd bundles`
3. You'll need to pass in credentials to connect to your Kubernetes cluster and MySQL database server.
```console
$ duffle creds add wordpress/example-wordpress-credential-set.yaml
$ duffle creds show example-wordpress-credential-set
```
4. Use the `duffle install` command by passing in a name (`wordpress`), a bundle metadata file (`-f <bundle.json>`) and a credential set(`-c example-wordpress-credential-set`):
```console
$ duffle install wordpress -f wordpress/cnab/bundle.json -c example-wordpress-credential-set
```

### Considerations for future iterations of this bundle
- Improve the `helm` configuration by configuring TLS. This will require passing in a tls cert via the credential set
- Create a step or an entirely separate bundle to provision a MySQL database instance
- Create a step or an entirely separate bundle to provision an a Kubernetes cluster
- Consider getting kubeconfig from azure-cli instead of passing the kubeconfig in credential set
