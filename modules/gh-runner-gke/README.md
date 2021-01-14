## Self Hosted Runners on GKE

This module handles the opinionated creation of infrastructure necessary to deploy Github Self Hosted Runners on GKE.

This includes:

- Enabling necessary APIs
- VPC
- GKE Cluster
- Kubernetes Secret

Below are some examples:

### [Self Hosted runners on GKE that support Docker workflows](../../examples/gh-runner-gke-dind/README.md)

This example shows how to deploy Self Hosted Runners on GKE that supports Docker Workflows.

### [Simple Self Hosted Runners on GKE](../../examples/gh-runner-gke-simple/README.md)

This example shows how to deploy a simple GKE Self Hosted Runner.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create\_network | When set to true, VPC will be auto created | `bool` | `true` | no |
| gh\_token | Github token that is used for generating Self Hosted Runner Token | `string` | n/a | yes |
| ip\_range\_pods\_cidr | The secondary ip range cidr to use for pods | `string` | `"192.168.0.0/18"` | no |
| ip\_range\_pods\_name | The secondary ip range to use for pods | `string` | `"ip-range-pods"` | no |
| ip\_range\_services\_cider | The secondary ip range cidr to use for services | `string` | `"192.168.64.0/18"` | no |
| ip\_range\_services\_name | The secondary ip range to use for services | `string` | `"ip-range-scv"` | no |
| machine\_type | Machine type for runner node pool | `string` | `"n1-standard-4"` | no |
| max\_node\_count | Maximum number of nodes in the runner node pool | `number` | `4` | no |
| min\_node\_count | Minimum number of nodes in the runner node pool | `number` | `2` | no |
| network\_name | Name for the VPC network | `string` | `"runner-network"` | no |
| project\_id | The project id to deploy Github Runner cluster | `string` | n/a | yes |
| region | The GCP region to deploy instances into | `string` | `"us-east4"` | no |
| repo\_name | Name of the repo for the Github Action | `string` | n/a | yes |
| repo\_owner | Owner of the repo for the Github Action | `string` | n/a | yes |
| repo\_url | Repo URL for the Github Action | `string` | n/a | yes |
| runner\_k8s\_config | Name for the k8s secret required to configure gh runners on GKE | `string` | `"runner-k8s-config"` | no |
| service\_account | Optional Service Account for the nodes | `string` | `""` | no |
| subnet\_ip | IP range for the subnet | `string` | `"10.0.0.0/17"` | no |
| subnet\_name | Name for the subnet | `string` | `"runner-subnet"` | no |
| subnetwork\_project | The ID of the project in which the subnetwork belongs. If it is not provided, the project\_id is used. | `string` | `""` | no |
| zones | The GCP zone to deploy gke into | `list(string)` | <pre>[<br>  "us-east4-a"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| ca\_certificate | The cluster ca certificate (base64 encoded) |
| client\_token | The bearer token for auth |
| cluster\_name | Cluster name |
| kubernetes\_endpoint | The cluster endpoint |
| location | Cluster location |
| network\_name | Name of VPC |
| service\_account | The default service account used for running nodes. |
| subnet\_name | Name of VPC |

 <!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

Before this module can be used on a project, you must ensure that the following pre-requisites are fulfilled:

1. Required APIs are activated

    ```
    "iam.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "containerregistry.googleapis.com",
    "container.googleapis.com",
    "storage-component.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com"
    ```
