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

variable "project_id" {
  type        = string
  description = "The project id to deploy Github Runner cluster"
}

variable "region" {
  type        = string
  description = "The GCP region to deploy instances into"
  default     = "us-east4"
}

variable "zones" {
  type        = list(string)
  description = "The GCP zone to deploy gke into"
  default     = ["us-east4-a"]
}

variable "ip_range_pods_name" {
  type        = string
  description = "The secondary ip range to use for pods"
  default     = "ip-range-pods"
}

variable "ip_range_services_name" {
  type        = string
  description = "The secondary ip range to use for services"
  default     = "ip-range-scv"
}

variable "ip_range_pods_cidr" {
  type        = string
  description = "The secondary ip range cidr to use for pods"
  default     = "192.168.0.0/18"
}

variable "ip_range_services_cider" {
  type        = string
  description = "The secondary ip range cidr to use for services"
  default     = "192.168.64.0/18"
}

variable "network_name" {
  type        = string
  description = "Name for the VPC network"
  default     = "runner-network"
}

variable "subnet_ip" {
  type        = string
  description = "IP range for the subnet"
  default     = "10.0.0.0/17"
}

variable "subnet_name" {
  type        = string
  description = "Name for the subnet"
  default     = "runner-subnet"
}

variable "create_network" {
  type        = bool
  description = "When set to true, VPC will be auto created"
  default     = true
}

variable "subnetwork_project" {
  type        = string
  description = "The ID of the project in which the subnetwork belongs. If it is not provided, the project_id is used."
  default     = ""
}

variable "machine_type" {
  type        = string
  description = "Machine type for runner node pool"
  default     = "n1-standard-4"
}

variable "max_node_count" {
  type        = number
  description = "Maximum number of nodes in the runner node pool"
  default     = 4
}

variable "min_node_count" {
  type        = number
  description = "Minimum number of nodes in the runner node pool"
  default     = 2
}

variable "gh_app_pre_defined_secret_name" {
  type        = string
  description = "Name for the k8s secret required to configure gh runners on GKE via GitHub App authentication"
  default     = "gh-app-pre-defined-secret"
}

variable "gh_app_id" {
  type        = string
  description = "After creating the GitHub App, on the GitHub App's page, note the value for \"App ID\"."
}

variable "gh_app_installation_id" {
  type        = string
  description = "You can find the app installation ID on the app installation page, which has the following URL format: `https://github.com/organizations/ORGANIZATION/settings/installations/INSTALLATION_ID`"
}

variable "gh_app_private_key" {
  type        = string
  description = "Under \"Private keys\", click Generate a private key, and save the .pem file. Use the contents of this file for this variable."
  sensitive   = true
}

variable "service_account" {
  type        = string
  description = "Optional Service Account for the nodes"
  default     = ""
}

variable "arc_systems_namespace" {
  type        = string
  description = "Namespace created for the ARC operator pods."
  default     = "arc-systems"
}

variable "arc_runners_namespace" {
  type        = string
  description = "Namespace created for the ARC runner pods."
  default     = "arc-runners"
}

variable "cluster_suffix" {
  type        = string
  description = "Name of the GitHub organization associated with this runner cluster."
  default     = "arc"
}

variable "gh_config_url" {
  type        = string
  description = "URL of GitHub App config. If installed in an organization, this is in the format \"https://github.com/ORGANIZATION\""
}

variable "arc_runners_version" {
  type        = string
  description = "Version tag for the ARC image. See [https://github.com/actions/actions-runner-controller/pkgs/container/actions-runner-controller-charts%2Fgha-runner-scale-set](https://github.com/actions/actions-runner-controller/pkgs/container/actions-runner-controller-charts%2Fgha-runner-scale-set) for releases."
  default     = "0.9.3"
}

variable "arc_controller_version" {
  type        = string
  description = "Version tag for the ARC image. See [https://github.com/actions/actions-runner-controller/pkgs/container/actions-runner-controller-charts%2Fgha-runner-scale-set-controller](https://github.com/actions/actions-runner-controller/pkgs/container/actions-runner-controller-charts%2Fgha-runner-scale-set-controller) for releases."
  default     = "0.9.3"
}

variable "arc_container_mode" {
  type        = string
  description = "value of containerMode.type in ARC runner scale set helm chart. If set, value can be `dind` or `kubernetes`"
  default     = ""
}

variable "arc_controller_values" {
  type        = list(string)
  description = "List of values in raw yaml format to pass to helm for ARC runners scale set controller chart"
  default     = []
}

variable "arc_runners_values" {
  type        = list(string)
  description = "List of values in raw yaml format to pass to helm for ARC runners scale set chart"
  default     = []
}

variable "enable_private_nodes" {
  type        = bool
  description = "Whether nodes have internal IP addresses only."
  default     = false
}

variable "spot" {
  type        = bool
  description = "A boolean that represents whether the underlying node VMs are spot"
  default     = false
}
