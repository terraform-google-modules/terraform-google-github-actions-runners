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
  description = "The project id to deploy Github Runner"
}

variable "region" {
  type        = string
  description = "The GCP region to deploy instances into"
  default     = "us-east4"
}

variable "zone" {
  type        = string
  description = "The GCP zone to deploy instances into"
  default     = "us-east4-b"
}

variable "network_name" {
  type        = string
  description = "Name for the VPC network"
  default     = "gh-runner-network"
}

variable "create_network" {
  type        = bool
  description = "When set to true, VPC,router and NAT will be auto created"
  default     = true
}

variable "subnetwork_project" {
  type        = string
  description = "The ID of the project in which the subnetwork belongs. If it is not provided, the project_id is used."
  default     = ""
}

variable "subnet_ip" {
  type        = string
  description = "IP range for the subnet"
  default     = "10.10.10.0/24"
}

variable "create_subnetwork" {
  type        = bool
  description = "Whether to create subnetwork or use the one provided via subnet_name"
  default     = true
}

variable "subnet_name" {
  type        = string
  description = "Name for the subnet"
  default     = "gh-runner-subnet"
}

variable "restart_policy" {
  type        = string
  description = "The desired Docker restart policy for the runner image"
  default     = "Always"
}

variable "repo_name" {
  type        = string
  description = "Name of the repo for the Github Action"
  default     = ""
}

variable "repo_owner" {
  type        = string
  description = "Owner of the repo for the Github Action"
}

variable "gh_runner_labels" {
  type        = set(string)
  description = "GitHub runner labels to attach to the runners. Docs: https://docs.github.com/en/actions/hosting-your-own-runners/using-labels-with-self-hosted-runners"
  default     = []
}

variable "min_replicas" {
  type        = number
  description = "Minimum number of runner instances"
  default     = 2
}

variable "max_replicas" {
  type        = number
  default     = 10
  description = "Maximum number of runner instances"
}

variable "gh_token" {
  type        = string
  description = "Github token that is used for generating Self Hosted Runner Token"
}

variable "instance_name" {
  type        = string
  description = "The gce instance name"
  default     = "gh-runner"
}

variable "service_account" {
  description = "Service account email address"
  type        = string
  default     = ""
}
variable "additional_metadata" {
  type        = map(any)
  description = "Additional metadata to attach to the instance"
  default     = {}
}
variable "machine_type" {
  type        = string
  description = "The GCP machine type to deploy"
  default     = "n1-standard-1"
}

variable "source_image_family" {
  type        = string
  description = "Source image family. If neither source_image nor source_image_family is specified, defaults to the latest public Ubuntu image."
  default     = "ubuntu-1804-lts"
}

variable "source_image_project" {
  type        = string
  description = "Project where the source image comes from"
  default     = "ubuntu-os-cloud"
}

variable "source_image" {
  type        = string
  description = "Source disk image. If neither source_image nor source_image_family is specified, defaults to the latest public CentOS image."
  default     = ""
}

variable "startup_script" {
  type        = string
  description = "User startup script to run when instances spin up"
  default     = ""
}

variable "shutdown_script" {
  type        = string
  description = "User shutdown script to run when instances shutdown"
  default     = ""
}

variable "custom_metadata" {
  type        = map(any)
  description = "User provided custom metadata"
  default     = {}
}

variable "cooldown_period" {
  description = "The number of seconds that the autoscaler should wait before it starts collecting information from a new instance."
  default     = 60
}

variable "update_policy" {
  description = "Update policy for the MIG. See https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_instance_group_manager#nested_update_policy"
  default = []
}

variable "startup_script_pre_github_runner_setup" {
  type        = string
  description = "Additional commands to run before the startup script"
  default     = ""
}

variable "startup_script_post_github_runner_setup" {
  type        = string
  description = "Additional commands to run after the startup script"
  default     = ""
}
