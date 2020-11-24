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

variable "runner_k8s_config" {
  type        = string
  description = "Name for the k8s secret required to configure gh runners on GKE"
  default     = "runner-k8s-config"
}

variable "repo_url" {
  type        = string
  description = "Repo URL for the Github Action"
}

variable "repo_name" {
  type        = string
  description = "Name of the repo for the Github Action"
}

variable "repo_owner" {
  type        = string
  description = "Owner of the repo for the Github Action"
}

variable "gh_token" {
  type        = string
  description = "Github token that is used for generating Self Hosted Runner Token"
}

variable "service_account" {
  type        = string
  description = "Optional Service Account for the nodes"
  default     = ""
}
