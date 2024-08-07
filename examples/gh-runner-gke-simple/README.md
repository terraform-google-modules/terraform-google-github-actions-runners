# Simple Self Hosted runners on GKE

## Overview

This example shows how to deploy ARC runners on GKE.

More examples of [Self Hosted Runners on GKE/Anthos](https://github.com/github-developer/self-hosted-runners-anthos).

## Deployment

1. Follow the instructions in the [GitHub documentation](https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners-with-actions-runner-controller/authenticating-to-the-github-api#authenticating-arc-with-a-github-app) to create a GitHub App for authenticating ARC

1. Gather the values for your GitHub App ID, GitHub App Installation ID, and GitHub App Private Key from the instructions linked above.

1. Substitute your values into the example [`main.tf`](main.tf). Modify any other values as needed. For a full list of available variables, refer to the [module documentation](../../modules/gh-runner-gke/).

1. Execute Terraform commands to create the required resources.
```sh
terraform init
terraform apply
```

1. Your runners should become active at `https://github.com/organizations/ORGANIZATION/settings/actions/runners`.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project\_id | The project id to deploy Github Runner MIG | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| cluster\_name | Cluster name |
| location | Cluster location |
| network\_name | Name of VPC |
| project\_id | The project in which resources are created |
| service\_account | The default service account used for running nodes. |
| subnet\_name | Name of VPC |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
