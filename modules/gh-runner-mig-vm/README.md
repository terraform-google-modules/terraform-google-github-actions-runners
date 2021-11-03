## Self Hosted Runners on Managed Instance Group

This module handles the opinionated creation of infrastructure necessary to deploy Github Self Hosted Runners on MIG.

This includes:

- Enabling necessary APIs
- VPC
- NAT & Cloud Router
- Service Account for MIG
- MIG Instance Template
- MIG Instance Manager
- FW Rules
- Secret Manager Secret

Below are some examples:

### [Simple Self Hosted Runner](../../examples/gh-runner-mig-native-simple/README.md)

This example shows how to deploy a MIG Self Hosted Runner bootstrapped using startup scripts.

### [Simple Self Hosted Runner](../../examples/gh-runner-mig-native-packer/README.md)

This example shows how to deploy a MIG Self Hosted Runner with an image pre-baked using Packer.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additional\_metadata | Additional metadata to attach to the instance | `map(any)` | `{}` | no |
| cooldown\_period | The number of seconds that the autoscaler should wait before it starts collecting information from a new instance. | `number` | `60` | no |
| create\_network | When set to true, VPC,router and NAT will be auto created | `bool` | `true` | no |
| create\_subnetwork | Whether to create subnetwork or use the one provided via subnet\_name | `bool` | `true` | no |
| custom\_metadata | User provided custom metadata | `map(any)` | `{}` | no |
| gh\_runner\_labels | GitHub runner labels to attach to the runners. Docs: https://docs.github.com/en/actions/hosting-your-own-runners/using-labels-with-self-hosted-runners | `set(string)` | `[]` | no |
| gh\_token | Github token that is used for generating Self Hosted Runner Token | `string` | n/a | yes |
| instance\_name | The gce instance name | `string` | `"gh-runner"` | no |
| machine\_type | The GCP machine type to deploy | `string` | `"n1-standard-1"` | no |
| max\_replicas | Maximum number of runner instances | `number` | `10` | no |
| min\_replicas | Minimum number of runner instances | `number` | `2` | no |
| network\_name | Name for the VPC network | `string` | `"gh-runner-network"` | no |
| project\_id | The project id to deploy Github Runner | `string` | n/a | yes |
| region | The GCP region to deploy instances into | `string` | `"us-east4"` | no |
| repo\_name | Name of the repo for the Github Action | `string` | `""` | no |
| repo\_owner | Owner of the repo for the Github Action | `string` | n/a | yes |
| restart\_policy | The desired Docker restart policy for the runner image | `string` | `"Always"` | no |
| service\_account | Service account email address | `string` | `""` | no |
| shutdown\_script | User shutdown script to run when instances shutdown | `string` | `""` | no |
| source\_image | Source disk image. If neither source\_image nor source\_image\_family is specified, defaults to the latest public CentOS image. | `string` | `""` | no |
| source\_image\_family | Source image family. If neither source\_image nor source\_image\_family is specified, defaults to the latest public Ubuntu image. | `string` | `"ubuntu-1804-lts"` | no |
| source\_image\_project | Project where the source image comes from | `string` | `"ubuntu-os-cloud"` | no |
| startup\_script | User startup script to run when instances spin up | `string` | `""` | no |
| subnet\_ip | IP range for the subnet | `string` | `"10.10.10.0/24"` | no |
| subnet\_name | Name for the subnet | `string` | `"gh-runner-subnet"` | no |
| subnetwork\_project | The ID of the project in which the subnetwork belongs. If it is not provided, the project\_id is used. | `string` | `""` | no |
| zone | The GCP zone to deploy instances into | `string` | `"us-east4-b"` | no |

## Outputs

| Name | Description |
|------|-------------|
| mig\_instance\_group | The instance group url of the created MIG |
| mig\_instance\_template | The name of the MIG Instance Template |
| mig\_name | The name of the MIG |
| network\_name | Name of VPC |
| service\_account | Service account email for GCE |
| subnet\_name | Name of VPC |

 <!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

Before this module can be used on a project, you must ensure that the following pre-requisites are fulfilled:

1. Required APIs are activated

    ```
    "iam.googleapis.com",
    "compute.googleapis.com",
    "storage-component.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "secretmanager.googleapis.com",
    ```
