# terraform-google-github-actions-runners

[![awesome-runners](https://img.shields.io/badge/listed%20on-awesome--runners-blue.svg)](https://github.com/jonico/awesome-runners)

Using these Terraform modules you can quickly deploy Self Hosted Github Runners for jobs in your GitHub Actions workflows

## [Self Hosted Runners on GKE](modules/gh-runner-gke/README.md)

The `gh-runner-gke` module provisions the resources required to deploy Self Hosted Runners on GCP infrastructure using GKE.

This includes

- Enabling necessary APIs
- VPC
- GKE Cluster
- Kubernetes Secret

Below are some examples:

### [Self Hosted runners on GKE that support Docker Workflows](examples/gh-runner-gke-dind/README.md)

This example shows how to deploy Self Hosted Runners on GKE that supports Docker Workflows.

### [Simple Self Hosted Runners on GKE](examples/gh-runner-gke-simple/README.md)

This example shows how to deploy a simple GKE Self Hosted Runner.

More examples of [Self Hosted Runners on GKE/Anthos](https://github.com/github-developer/self-hosted-runners-anthos).

## [Self Hosted Runners on Managed Instance Groups using VMs](modules/gh-runner-mig-vm/README.md)

The `gh-runner-mig-vm` module provisions the resources required to deploy Self Hosted Runners on GCP infrastructure using Managed Instance Groups.

This includes

- Enabling necessary APIs
- VPC
- NAT & Cloud Router
- Service Account for MIG
- MIG Instance Template
- MIG Instance Manager
- FW Rules
- Secret Manager Secret

Deployment of Managed Instance Groups requires a [Google VM image](https://cloud.google.com/compute/docs/images) with a startup script that downloads and configures the Runner or a pre-baked image with the runner installed.

Below are some examples:

### [Simple Self Hosted Runner on MIG VMs](examples/gh-runner-mig-native-simple/README.md)

This example shows how to deploy a MIG Self Hosted Runner with startup scripts.

### [Self Hosted Runner on MIG VMs from Packer Image](examples/gh-runner-mig-native-packer/README.md)

This example shows how to deploy a MIG Self Hosted Runner with an image pre-baked using Packer.

## [Self Hosted Runners on Managed Instance Groups using Container VMs](modules/gh-runner-mig-container-vm/README.md)

The `gh-runner-mig-container-vm` module provisions the resources required to deploy Self Hosted Runners on GCP infrastructure using Managed Instance Groups.

This includes

- Enabling necessary APIs
- VPC
- NAT & Cloud Router
- MIG Container Instance Template
- MIG Instance Manager
- FW Rules

Below are some examples:

### [Self Hosted runners on MIG Container VMs that support Docker Workflows](examples/gh-runner-mig-container-vm-dind/README.md)

This example shows how to deploy a Self Hosted Runner that supports Docker Workflows on MIG Container VMs.

### [Simple Self Hosted Runner on MIG Container VMs](examples/gh-runner-mig-container-vm-simple/README.md)

This example shows how to deploy a Self Hosted Runner on MIG Container VMs.


## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- [Terraform][terraform] v0.13
- [Terraform Provider for GCP][terraform-provider-gcp]

## Contributing

Refer to the [contribution guidelines](./CONTRIBUTING.md) for
information on contributing to this module.

[terraform-provider-gcp]: https://www.terraform.io/docs/providers/google/index.html
[terraform]: https://www.terraform.io/downloads.html
