# Example Runners that support Docker Workflows

## Overview

This example showcases how to use startup scripts to deploy runners using the `gh-runner-mig` module.

We use startup/shutdown scripts to install the runner binary, register the runner when it comes online and de-register when shut down.

## Steps to deploy this example

- Step 1: Create terraform.tfvars file with the necessary values.

Access tokens require repo scope for private repos and public_repo scope for public repos. GitHub Apps must have the administration permission to use this API. Authenticated users must have admin access to the repository to use this API.

More info can be found [here](https://developer.github.com/v3/actions/self_hosted_runners/).

```sh
project_id   = "your-project-id"
gh_token     = "your-github-token"
repo_name    = "your-repo-name"
repo_owner   = "owner"
```

- Step 2: Create the infrastructure

```sh
$ terraform init
$ terraform plan
$ terraform apply
```

- Step 3: Your runners should become active at https://github.com/owner/your-repo-name/settings/actions.


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| gh\_token | Github token that is used for generating Self Hosted Runner Token | `string` | n/a | yes |
| project\_id | The project id to deploy Github Runner MIG | `string` | n/a | yes |
| repo\_name | Name of the repo for the Github Action | `string` | n/a | yes |
| repo\_owner | Owner of the repo for the Github Action | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| mig\_instance\_group | The instance group url of the created MIG |
| mig\_instance\_template | The name of the MIG Instance Template |
| mig\_name | The name of the MIG |
| service\_account | Service account email for GCE |

 <!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
