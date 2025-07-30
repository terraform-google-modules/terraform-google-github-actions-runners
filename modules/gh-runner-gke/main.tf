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
locals {
  network_name    = var.create_network ? google_compute_network.gh-network[0].name : var.network_name
  subnet_name     = var.create_network ? google_compute_subnetwork.gh-subnetwork[0].name : var.subnet_name
  service_account = var.service_account == "" ? "create" : var.service_account
}

/*****************************************
  Optional Network
 *****************************************/
resource "google_compute_network" "gh-network" {
  count                   = var.create_network ? 1 : 0
  name                    = var.network_name
  project                 = var.project_id
  auto_create_subnetworks = false
}
resource "google_compute_subnetwork" "gh-subnetwork" {
  count         = var.create_network ? 1 : 0
  project       = var.project_id
  name          = var.subnet_name
  ip_cidr_range = var.subnet_ip
  region        = var.region
  network       = google_compute_network.gh-network[0].name

  secondary_ip_range {
    range_name    = var.ip_range_pods_name
    ip_cidr_range = var.ip_range_pods_cidr
  }

  secondary_ip_range {
    range_name    = var.ip_range_services_name
    ip_cidr_range = var.ip_range_services_cider
  }
}
/*****************************************
  Runner GKE
 *****************************************/
module "runner-cluster" {
  source                   = "terraform-google-modules/kubernetes-engine/google//modules/beta-public-cluster/"
  version                  = "~> 35.0"
  project_id               = var.project_id
  name                     = "gh-runner-${var.cluster_suffix}"
  regional                 = false
  region                   = var.region
  zones                    = var.zones
  network                  = local.network_name
  network_project_id       = var.subnetwork_project != "" ? var.subnetwork_project : var.project_id
  subnetwork               = local.subnet_name
  ip_range_pods            = var.ip_range_pods_name
  ip_range_services        = var.ip_range_services_name
  logging_service          = "logging.googleapis.com/kubernetes"
  monitoring_service       = "monitoring.googleapis.com/kubernetes"
  remove_default_node_pool = true
  service_account          = local.service_account
  gce_pd_csi_driver        = true
  deletion_protection      = false
  node_pools = [
    {
      name                 = "runner-pool"
      min_count            = var.min_node_count
      max_count            = var.max_node_count
      auto_upgrade         = true
      machine_type         = var.machine_type
      enable_private_nodes = var.enable_private_nodes
    }
  ]
}

data "google_client_config" "default" {
}

resource "kubernetes_namespace" "arc_systems" {
  metadata {
    name = var.arc_systems_namespace
  }
}

resource "kubernetes_namespace" "arc_runners" {
  metadata {
    name = var.arc_runners_namespace
  }

  depends_on = [helm_release.arc]
}

/*****************************************
  K8S secrets for configuring k8s runners
 *****************************************/
resource "kubernetes_secret" "gh_app_pre_defined_secret" {
  metadata {
    name      = var.gh_app_pre_defined_secret_name
    namespace = kubernetes_namespace.arc_runners.metadata[0].name
  }
  data = {
    github_app_id              = var.gh_app_id
    github_app_installation_id = var.gh_app_installation_id
    github_app_private_key     = var.gh_app_private_key
  }
}

resource "helm_release" "arc" {
  name      = "arc"
  namespace = kubernetes_namespace.arc_systems.metadata[0].name
  chart     = "oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set-controller"
  version   = var.arc_controller_version
  wait      = true
  values    = var.arc_controller_values
}

resource "helm_release" "arc_runners_set" {
  name      = "arc-runners"
  namespace = kubernetes_namespace.arc_runners.metadata[0].name
  chart     = "oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set"
  version   = var.arc_runners_version

  set = concat(
    [
      {
        name  = "githubConfigSecret"
        value = kubernetes_secret.gh_app_pre_defined_secret.metadata[0].name
      },
      {
        name  = "githubConfigUrl"
        value = var.gh_config_url
      }
    ],
    var.arc_container_mode == "" ? [] : [
      {
        name  = "containerMode.type"
        value = var.arc_container_mode
      }
    ]
  )

  values = var.arc_runners_values
}
