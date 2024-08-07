# Upgrading to v4.0

The v4.0 release of the `gh-runner-gke` module contains breaking changes.
## Migration Instructions

### `gh-runner-gke` module

```diff
 module "runner-gke" {
  source  = "terraform-google-modules/github-actions-runners/google//modules/gh-runner-gke"
-  version = "~> 3.0"
+  version = "~> 4.0"

  project_id             = var.project_id
  create_network         = true
+  cluster_suffix         = "repo"
-  repo_name              = "repo"
-  repo_owner             = "repo_owner"
-  repo_url               = "repo_url"
-  gh_token               = "gh_token"
+  gh_app_id              = "123456"
+  gh_app_installation_id = "12345678"
+  gh_app_private_key     = "sample"
+  gh_config_url          = "https://github.com/ORGANIZATION"
}
```

- Previously, the name of the created GKE cluster appended `repo_name` as a suffix. Now, the value of the suffix is set via `cluster_suffix`, as runner clusters can be created for workflows more than one GitHub repo. To prevent cluster deletion when upgrading, set the value of `cluster_suffix` to the previous value of `repo_name`.
- The module now prefers authentication via GitHub App installation. Follow the instructions for [authenticating to ARC via GitHub App](https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners-with-actions-runner-controller/authenticating-to-the-github-api#authenticating-arc-with-a-github-app), and provide the necessary values to the module instead of the previous repo authentication values. Upgrading will destroy the previously created `runner_k8s_config` kubernetes secret, so previous GitHub Runner images may fail.
- Previously, the GKE cluster service account was provided with the `roles/storage.objectViewer` role to enable pulling images from Container Registry. The module no longer requires access to Container Registry, and so IAM membership has been removed. If your cluster relies on this role, you will need to add it again manually.
