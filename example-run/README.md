# example-run

This bundle exhibits how to create custom run targets

To build this demo, run the following commands from the root of the `bundles` repo:

```
$ BUNDLE=example-run make build
```

## Using This Bundle

This bundle shows how to use Duffle's experimental support for custom actions:

```json
{
    "name": "example-run",
    "version": "0.0.1",
    "invocationImages": [
        {
        "imageType": "docker",
        "image": "cnab/example-run:0.1.0"
      }
    ],
    "images": [],
    "parameters": {
        "greeting": {
            "defaultValue": "hello",
            "type": "string",
            "metadata":{
                "description": "this will be in $GREETING"
            }
        }
    },
    "actions": {
        "greet": {
            "modifies": false
        },
        "migrate": {
            "modifies": true
        }
    }
}
```

To execute this bundle, run the following from this `example-run` directory:

```console
$ duffle install -f ./bundle.cnab example-run
$ duffle run greet example-run --set greeting=HELLO
$ duffle run migrate example-run --set greeting=HELLO
$ duffle claim list
```