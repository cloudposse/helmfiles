# Splunk

## Prerequisites

Before installing this helmfile project to a specific cluster, we must first obtain the `token` from Splunk and write it to AWS SSM. For additional information on how to obtain this value from Splunk, please consult the following documentation [here](https://github.com/splunk/splunk-connect-for-kubernetes).

Once the token is generated, write it to the SSM key store at the following location...

| Key         | SSM Path           |
| ----------- | ------------------ |
| Token      | `/splunk/token` |

**NOTE: The SSM store must be located in the same AWS account & region as the destination EKS cluster.**
