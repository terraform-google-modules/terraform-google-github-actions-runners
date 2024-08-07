# terraform-google-github-actions-runners
[![awesome-runners](https://img.shields.io/badge/listed%20on-awesome--runners-blue.svg)](https://github.com/jonico/awesome-runners)

## Description
Using these Terraform modules you can quickly deploy self-hosted GitHub Runners for jobs in your GitHub Actions workflows

## Modules

### [Self Hosted Runners on GKE](modules/gh-runner-gke/)
The `gh-runner-gke` module provisions the resources required to deploy Self Hosted Runners on GCP infrastructure using GKE. This module follows the guidance for using [Actions Runner Controller](https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners-with-actions-runner-controller/quickstart-for-actions-runner-controller#installing-actions-runner-controller) provided by GitHub

Examples:
- [Simple Self Hosted Runners on GKE](examples/gh-runner-gke-simple/)
- [Self Hosted runners on GKE that support Docker Workflows](examples/gh-runner-gke-dind/)
- [Self Hosted runners on GKE that support Docker Workflows in rootless configuration](examples/gh-runner-gke-dind-rootless/)

More examples of [Self Hosted Runners on GKE/Anthos](https://github.com/github-developer/self-hosted-runners-anthos).


### [Self Hosted Runners on Managed Instance Groups using VMs](modules/gh-runner-mig-vm/)
The `gh-runner-mig-vm` module provisions the resources required to deploy Self Hosted Runners on GCP infrastructure using Managed Instance Groups.

Examples:
- [Simple Self Hosted Runner on MIG VMs](examples/gh-runner-mig-native-simple/)
- [Self Hosted Runner on MIG VMs from Packer Image](examples/gh-runner-mig-native-packer/)

### [Self Hosted Runners on Managed Instance Groups using Container VMs](modules/gh-runner-mig-container-vm/)
The `gh-runner-mig-container-vm` module provisions the resources required to deploy Self Hosted Runners on GCP infrastructure using Managed Instance Groups.

Examples:
- [Simple Self Hosted Runner on MIG Container VMs](examples/gh-runner-mig-container-vm-simple/)
- [Self Hosted runners on MIG Container VMs that support Docker Workflows](examples/gh-runner-mig-container-vm-dind/)

### [GitHub OIDC](modules/gh-oidc/)
This module handles the opinionated creation of infrastructure necessary to configure [Workload Identity pools](https://cloud.google.com/iam/docs/workload-identity-federation#pools) and [providers](https://cloud.google.com/iam/docs/workload-identity-federation#providers) for authenticating to GCP using GitHub Actions OIDC tokens.

Examples:
- [Simple Workload Identity configuration for GitHub OIDC](examples/oidc-simple/)


## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- [Terraform][terraform] v0.13
- [Terraform Provider for GCP][terraform-provider-gcp]

## Contributing

Refer to the [contribution guidelines](./CONTRIBUTING.md) for
information on contributing to this module.

[iam-module]: https://registry.terraform.io/modules/terraform-google-modules/iam/google
[project-factory-module]: https://registry.terraform.io/modules/terraform-google-modules/project-factory/google
[terraform-provider-gcp]: https://www.terraform.io/docs/providers/google/index.html
[terraform]: https://www.terraform.io/downloads.html

## Security Disclosures

Please see our [security disclosure process](./SECURITY.md).
