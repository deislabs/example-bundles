## Installation

Create credentials for this app with:

```
$ az ad sp create-for-rbac -n "<yourAppName>" 
{
  "appId": "YOUR_CLIENT_ID",
  "displayName": "armbasetest",
  "name": "http://armbasetest",
  "password": "YOUR_CLIENT_SECRET",
  "tenant": "YOUR_TENANT_ID"
}
```

You can get the subscription ID for the appropriate subscription using:

```console
$ az account list -o table
Name                                            CloudName    SubscriptionId                        State    IsDefault
----------------------------------------------  -----------  ------------------------------------  -------  -----------
# list of stuff
```

Now create the following environment variables:

```
AZURE_CLIENT_ID=<YOUR_CLIENT_ID>
AZURE_CLIENT_SECRET=<YOUR_CLIENT_SECRET>
AZURE_TENANT_ID=<YOUR_TENANT_ID>
AZURE_SUBSCRIPTION_ID=<YOUR_SUBSCRIPTION_ID>
```

## Templates

ARM templates are a declarative language for installing stuff.

The [template format](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-authoring-templates) looks essentially like this:

```json
{
    "$schema": "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
    "contentVersion": "",
    "parameters": {  },
    "variables": {  },
    "functions": {  },
    "resources": [  ],
    "outputs": {  }
}
```

## Parameters

Parameters are passed in according to the format described here: https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-template-deploy-cli#parameter-files

Example:

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
     "storageAccountType": {
         "value": "Standard_GRS"
     }
  }
}
```