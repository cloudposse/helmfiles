# Codefresh Runners

## Prerequisites

### API Key

Prior to deployment, the API token must exist in SSM.

To generate the token, please follow the instructions [here](https://codefresh.io/docs/docs/integrations/codefresh-api/#authentication-instructions). 
Additionally, the token must have the following Codefresh permissions...

| Type | Permission(s) |
| ---- | ------------- |
| `Agent` | `Read` / `Write` |
| `Cluster` | `Write` |
| `Clusters` | `Read` |
| `Runner-installation` | `Read` / `Write` |

Finally, once the token is generated, write it to the SSM key store at the following location within the `automation` account...

| Key         | SSM Path           | Type           |
| ----------- | ------------------ | -------------- |
| API         | `/codefresh/api_token` | `SecureString` |


## Known Issues

The latest version of the `codefresh/cli` deployment container, which is utilized by the official Codefresh `runner-installation` helm chart, has a known issue where the Codefresh components are deployed with an invalid Docker image. In each case, the Docker image contains an extra `codefresh/` at the beginning the name.

For example, the `runner` pod will be deployed with the image `codefresh/codefresh/venona`, which is an invalid. The correct image name is `codefresh/venona`. **Codefresh is aware and actively working to resolve this issue.**

To resolve this issue (manually), simply edit the deployment or daemon set for any service failing to pull an image, and remove the first `codefresh/` from the Docker image name. This is a one-time operation that must be performed during a fresh installation of this project.
