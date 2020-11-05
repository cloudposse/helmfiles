# Configuration

## API & Application Keys

Before installing this helmfile project to a specific cluster, first create `API` and `Application` keys within the DataDog dashboard. To do so, please follow the instructions [here](https://docs.datadoghq.com/account_management/api-app-keys/).

Once the keys are generated, write them to the SSM key store at the following locations...

| Key         | SSM Path           |
| ----------- | ------------------ |
| API         | `/datadog/api_key` |
| Application | `/datadog/app_key` |

**NOTE: The SSM store must be located in the same AWS account & region as the destination EKS cluster.**

## Monitoring Defaults

By default, only the Kubernetes cluster agent monitoring is enabled. Please see `defaults.yaml` for information on how to enable additional monitoring.
