## Self Hosted Runners on Managed Instance Group

This module handles the opinionated creation of infrastructure necessary to deploy Github Self Hosted Runners on MIG Container VMs.

This includes:

- Enabling necessary APIs
- VPC
- NAT & Cloud Router
- MIG Container Instance Template
- MIG Instance Manager
- FW Rules

Below are some examples:

### [Self Hosted runners that support Docker Workflows](../../examples/gh-runner-mig-container-vm-dind/README.md)

This example shows how to deploy a Self Hosted Runner that supports Docker Workflows on MIG Container VMs.

### [Simple Self Hosted Runner](../../examples/gh-runner-mig-container-vm-simple/README.md)

This example shows how to deploy a Self Hosted Runner on MIG Container VMs.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additional\_metadata | Additional metadata to attach to the instance | `map(any)` | `{}` | no |
| cooldown\_period | The number of seconds that the autoscaler should wait before it starts collecting information from a new instance. | `number` | `60` | no |
| create\_network | When set to true, VPC,router and NAT will be auto created | `bool` | `true` | no |
| dind | Flag to determine whether to expose dockersock | `bool` | `false` | no |
| gh\_token | Github token that is used for generating Self Hosted Runner Token | `string` | n/a | yes |
| image | The github runner image | `string` | n/a | yes |
| instance\_name | The gce instance name | `string` | `"gh-runner"` | no |
| network\_name | Name for the VPC network | `string` | `"gh-runner-network"` | no |
| project\_id | The project id to deploy Github Runner | `string` | n/a | yes |
| region | The GCP region to deploy instances into | `string` | `"us-east4"` | no |
| repo\_name | Name of the repo for the Github Action | `string` | n/a | yes |
| repo\_owner | Owner of the repo for the Github Action | `string` | n/a | yes |
| repo\_url | Repo URL for the Github Action | `string` | n/a | yes |
| restart\_policy | The desired Docker restart policy for the runner image | `string` | `"Always"` | no |
| service\_account | Service account email address | `string` | `""` | no |
| subnet\_ip | IP range for the subnet | `string` | `"10.10.10.0/24"` | no |
| subnet\_name | Name for the subnet | `string` | `"gh-runner-subnet"` | no |
| subnetwork\_project | The ID of the project in which the subnetwork belongs. If it is not provided, the project\_id is used. | `string` | `""` | no |
| target\_size | The number of runner instances | `number` | `2` | no |

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
    "cloudresourcemanager.googleapis.com",
    "containerregistry.googleapis.com",
    "storage-component.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com"
    ```
