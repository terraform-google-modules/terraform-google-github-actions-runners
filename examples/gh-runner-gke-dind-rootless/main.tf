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

  project_id             = var.project_id
  create_network         = true
  network_name           = "runner-network-dind-r"
  subnet_name            = "runner-subnet-dind-r"
  cluster_suffix         = "dind-rootless"
  gh_app_id              = "123456"
  gh_app_installation_id = "12345678"
  gh_app_private_key     = "sample"
  gh_config_url          = "https://github.com/ORGANIZATION"

  # pass values.yaml for dind-rootless runners configuratin
  arc_runners_values = [
    file("${path.module}/values.yaml")
  ]
}
