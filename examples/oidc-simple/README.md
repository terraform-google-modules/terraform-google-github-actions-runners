# OIDC Simple Example

## Overview

This example showcases how to configure [Workload Identity Federation](https://cloud.google.com/iam/docs/workload-identity-federation) using the [gh-oidc module](../../modules/gh-oidc/README.md) for a sample Service Account.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project\_id | The project id to create WIF pool and example SA | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| pool\_name | Pool name |
| provider\_name | Provider name |
| sa\_email | Example SA email |

 <!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
