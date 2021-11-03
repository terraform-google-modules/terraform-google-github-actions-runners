# Example Runners on MIG Container VM that support Docker Workflows

## Overview

This example shows how to deploy a runner that supports Docker Workflows on GCE Container VM.

## Steps to deploy this example

- Step 1: Build the example runner image using Google Cloud Build. Alternatively, you can also use a prebuilt image or build using a local docker daemon.

```sh
$ gcloud config set project $PROJECT_ID
$ gcloud services enable containerregistry.googleapis.com cloudbuild.googleapis.com
$ gcloud builds submit --config=cloudbuild.yaml
```

- Step 2: Create terraform.tfvars file with the necessary values.

Access tokens require repo scope for private repos and public_repo scope for public repos. GitHub Apps must have the administration permission to use this API. Authenticated users must have admin access to the repository to use this API.

More info can be found [here](https://developer.github.com/v3/actions/self_hosted_runners/).

```tf
project_id = "your-project-id"
image      = "your-image-registry/image:tag"
gh_token   = "your-github-token"
repo_url   = "https://github.com/owner/your-repo-name"
repo_name  = "your-repo-name"
repo_owner = "owner"
```

- Step 3: Create the infrastructure.

```sh
$ terraform init
$ terraform plan
$ terraform apply
```

- Step 4: Your runners should become active at https://github.com/owner/your-repo-name/settings/actions.


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| gh\_token | Github token that is used for generating Self Hosted Runner Token | `string` | n/a | yes |
| image | The github runner image | `string` | n/a | yes |
| project\_id | The project id to deploy Github Runner MIG | `string` | n/a | yes |
| repo\_name | Name of the repo for the Github Action | `string` | n/a | yes |
| repo\_owner | Owner of the repo for the Github Action | `string` | n/a | yes |
| repo\_url | Repo URL for the Github Action | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| mig\_instance\_group | The instance group url of the created MIG |
| mig\_name | The name of the MIG |

 <!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
