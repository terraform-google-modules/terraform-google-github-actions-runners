# Example Runners that support Docker Workflows

## Overview

This example showcases how to use Packer to pre-bake a Google VM Image with the necessary toolchain including Github Actions Runner and deploy this image using the `gh-runner-mig` module.

We use startup/shutdown scripts to register the runner when it comes online and de-register when it is shut down.

In this example, Packer creates a VM image that has the following:

- curl
- jq
- Docker
- Github Actions Runner

## Steps to deploy this example

- Step 1: Enable APIs necessary to build an GCE VM image using Packer and Google Cloud Build.

```sh
$ gcloud config set project $PROJECT_ID
$ gcloud services enable compute.googleapis.com cloudbuild.googleapis.com
```


- Step 2: Give Cloud Build Service Account necessary permissions to create a new GCE VM Image using Packer.

```sh
$ CLOUD_BUILD_ACCOUNT=$(gcloud projects get-iam-policy $PROJECT_ID --filter="(bindings.role:roles/cloudbuild.builds.builder)"  --flatten="bindings[].members" --format="value(bindings.members[])")
$ gcloud projects add-iam-policy-binding $PROJECT_ID --member $CLOUD_BUILD_ACCOUNT --role roles/compute.instanceAdmin.v1
$ gcloud projects add-iam-policy-binding $PROJECT_ID --member $CLOUD_BUILD_ACCOUNT --role roles/iam.serviceAccountUser
```

- Step 3: Build GCE VM image. When the build finishes, the image id of the form `gh-actions-image-*` will be displayed. We will use this in the tfvars we create in step 4.

```sh
$ gcloud builds submit --config=cloudbuild.yaml
```

- Step 4: Create terraform.tfvars file with the necessary values.

Access tokens require repo scope for private repos and public_repo scope for public repos. GitHub Apps must have the administration permission to use this API. Authenticated users must have admin access to the repository to use this API.

More info can be found [here](https://developer.github.com/v3/actions/self_hosted_runners/)

```tf
project_id   = "your-project-id"
source_image = "image-id-from-step-3"
gh_token     = "your-github-token"
repo_url     = "https://github.com/owner/your-repo-name"
repo_name    = "your-repo-name"
repo_owner   = "owner"
```

- Step 5: Create the infrastructure

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
| project\_id | The project id to deploy Github Runner MIG | `string` | n/a | yes |
| repo\_name | Name of the repo for the Github Action | `string` | n/a | yes |
| repo\_owner | Owner of the repo for the Github Action | `string` | n/a | yes |
| repo\_url | Repo URL for the Github Action | `string` | n/a | yes |
| source\_image | Source disk image | `string` | n/a | yes |
| source\_image\_project | Project where the source image comes from | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| mig\_instance\_group | The instance group url of the created MIG |
| mig\_instance\_template | The name of the MIG Instance Template |
| mig\_name | The name of the MIG |
| service\_account | Service account email for GCE |

 <!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
