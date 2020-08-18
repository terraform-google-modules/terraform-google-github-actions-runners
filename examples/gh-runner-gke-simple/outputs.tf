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

output "kubernetes_endpoint" {
  description = "The cluster endpoint"
  sensitive   = true
  value       = module.runner-gke.kubernetes_endpoint
}

output "client_token" {
  description = "The bearer token for auth"
  sensitive   = true
  value       = module.runner-gke.client_token
}

output "ca_certificate" {
  description = "The cluster ca certificate (base64 encoded)"
  value       = module.runner-gke.ca_certificate
}

output "service_account" {
  description = "The default service account used for running nodes."
  value       = module.runner-gke.service_account
}

output "cluster_name" {
  description = "Cluster name"
  value       = module.runner-gke.cluster_name
}

output "network_name" {
  description = "Name of VPC"
  value       = module.runner-gke.network_name
}

output "subnet_name" {
  description = "Name of VPC"
  value       = module.runner-gke.subnet_name
}

output "location" {
  description = "Cluster location"
  value       = module.runner-gke.location
}
