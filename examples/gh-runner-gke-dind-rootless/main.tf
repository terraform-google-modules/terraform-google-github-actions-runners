/**
 * Copyright 2020 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

module "runner-gke" {
  source  = "terraform-google-modules/github-actions-runners/google//modules/gh-runner-gke"
  version = "~> 3.0"

  create_network         = true
  project_id             = var.project_id
  org_name               = "dind-rootless"
  gh_app_id              = "123456"
  gh_app_installation_id = "12345678"
  gh_app_private_key     = "sample"
}


resource "helm_release" "arc_runners_set" {
  name        = "arc-runners"
  namespace   = module.runner-gke.arc_runners_namespace
  chart       = "oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set"

  values = [
    "${file("values.yaml")}"
  ]

  set {
    name = "githubConfigSecret"
    value = module.runner-gke.gha_secret_name
  }
}
