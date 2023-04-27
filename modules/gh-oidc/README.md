## GitHub OIDC

This module handles the opinionated creation of infrastructure necessary to configure [Workload Identity pools](https://cloud.google.com/iam/docs/workload-identity-federation#pools) and [providers](https://cloud.google.com/iam/docs/workload-identity-federation#providers) for authenticating to GCP using GitHub Actions OIDC tokens.

This includes:

- Creation of a Workload Identity pool
- Configuring a Workload Identity provider
- Granting external identities necessary IAM roles on Service Accounts

### Example Usage

```terraform
module "gh_oidc" {
  source      = "terraform-google-modules/github-actions-runners/google//modules/gh-oidc"
  project_id  = var.project_id
  pool_id     = "example-pool"
  provider_id = "example-gh-provider"
  sa_mapping = {
    "foo-service-account" = {
      sa_name   = "projects/my-project/serviceAccounts/foo-service-account@my-project.iam.gserviceaccount.com"
      attribute = "attribute.repository/${USER/ORG}/<repo>"
    }
  }
}
```

Below are some examples:

### [OIDC Simple](../../examples/oidc-simple/README.md)

This example shows how to use this module along with a Service Account to access storage buckets.

### GitHub Workflow

Once provisioned, you can use the [google-github-actions/auth](https://github.com/google-github-actions/auth) Action in a workflow as shown below

```yaml
# Example workflow
# .github/workflows/example.yml

name: 'example oidc'
on:
  push:
    branches:
    - 'main'
jobs:
  run:
    name: 'example to list bucket contents'
    permissions:
      id-token: write
      contents: read
    runs-on: 'ubuntu-latest'
    steps:
    - id: 'auth'
      uses: 'google-github-actions/auth@v1'
      with:
        token_format: 'access_token'
        workload_identity_provider: ${{ secrets.PROVIDER_NAME }} # this is the output provider_name from the TF module
        service_account: ${{ secrets.SA_EMAIL }} # this is a SA email configured using the TF module with access to YOUR-GCS-BUCKET
    - id: 'list-buckets-contents'
      run: |-
        curl -sSf https://storage.googleapis.com/storage/v1/b/YOUR-GCS-BUCKET/o \
          --header "Authorization: Bearer ${{ steps.auth.outputs.access_token }}"
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allowed\_audiences | Workload Identity Pool Provider allowed audiences. | `list(string)` | `[]` | no |
| attribute\_condition | Workload Identity Pool Provider attribute condition expression. [More info](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool_provider#attribute_condition) | `string` | `null` | no |
| attribute\_mapping | Workload Identity Pool Provider attribute mapping. [More info](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool_provider#attribute_mapping) | `map(any)` | <pre>{<br>  "attribute.actor": "assertion.actor",<br>  "attribute.aud": "assertion.aud",<br>  "attribute.repository": "assertion.repository",<br>  "google.subject": "assertion.sub"<br>}</pre> | no |
| issuer\_uri | Workload Identity Pool Issuer URL | `string` | `"https://token.actions.githubusercontent.com"` | no |
| pool\_description | Workload Identity Pool description | `string` | `"Workload Identity Pool managed by Terraform"` | no |
| pool\_display\_name | Workload Identity Pool display name | `string` | `null` | no |
| pool\_id | Workload Identity Pool ID | `string` | n/a | yes |
| project\_id | The project id to create Workload Identity Pool | `string` | n/a | yes |
| provider\_description | Workload Identity Pool Provider description | `string` | `"Workload Identity Pool Provider managed by Terraform"` | no |
| provider\_display\_name | Workload Identity Pool Provider display name | `string` | `null` | no |
| provider\_id | Workload Identity Pool Provider id | `string` | n/a | yes |
| sa\_mapping | Service Account resource names and corresponding WIF provider attributes. If attribute is set to `*` all identities in the pool are granted access to SAs. | <pre>map(object({<br>    sa_name   = string<br>    attribute = string<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| pool\_name | Pool name |
| provider\_name | Provider name |

 <!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

Before this module can be used on a project, you must ensure that the following pre-requisites are fulfilled:

1. Required APIs are activated

    ```
    "iam.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "iamcredentials.googleapis.com",
    "sts.googleapis.com",
    ```

1. Service Account used to deploy this module has the following roles

    ```
    roles/iam.workloadIdentityPoolAdmin
    roles/iam.serviceAccountAdmin
    ```
