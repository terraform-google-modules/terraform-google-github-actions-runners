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
  network_name    = var.create_network ? google_compute_network.gh-network[0].self_link : var.network_name
  subnet_name     = var.create_network ? google_compute_subnetwork.gh-subnetwork[0].self_link : var.subnet_name
  service_account = var.service_account == "" ? google_service_account.runner_service_account[0].email : var.service_account
  shutdown_script = {
    "shutdown-script" = var.shutdown_script
  }
}

/*****************************************
  Optional Runner Networking
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
}

resource "google_compute_router" "default" {
  count   = var.create_network ? 1 : 0
  name    = "${var.network_name}-router"
  network = google_compute_network.gh-network[0].self_link
  region  = var.region
  project = var.project_id
}

resource "google_compute_router_nat" "nat" {
  count                              = var.create_network ? 1 : 0
  project                            = var.project_id
  name                               = "${var.network_name}-nat"
  router                             = google_compute_router.default[0].name
  region                             = google_compute_router.default[0].region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}


/*****************************************
  IAM Bindings GCE SVC
 *****************************************/

resource "google_service_account" "runner_service_account" {
  count        = var.service_account == "" ? 1 : 0
  project      = var.project_id
  account_id   = "runner-service-account"
  display_name = "Github Runner GCE Service Account"
}

/*****************************************
  Runner Secrets
 *****************************************/
resource "google_secret_manager_secret" "gh-secret" {
  provider  = google-beta
  project   = var.project_id
  secret_id = "gh-token"

  labels = {
    label = "gh-token"
  }

  replication {
    user_managed {
      replicas {
        location = "us-central1"
      }
      replicas {
        location = "us-east1"
      }
    }
  }
}
resource "google_secret_manager_secret_version" "gh-secret-version" {
  provider = google-beta
  secret   = google_secret_manager_secret.gh-secret.id
  secret_data = jsonencode({
    "REPO_NAME"    = var.repo_name
    "REPO_OWNER"   = var.repo_owner
    "REPO_URL"     = var.repo_url
    "GITHUB_TOKEN" = var.gh_token
  })
}


resource "google_secret_manager_secret_iam_member" "gh-secret-member" {
  provider  = google-beta
  project   = var.project_id
  secret_id = google_secret_manager_secret.gh-secret.id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${local.service_account}"
}

/*****************************************
  Runner GCE Instance Template
 *****************************************/
locals {
  instance_name = "gh-runner-vm"
}


module "mig_template" {
  source     = "terraform-google-modules/vm/google//modules/instance_template"
  version    = "~> 2.0"
  project_id = var.project_id
  network    = local.network_name
  subnetwork = local.subnet_name
  service_account = {
    email = local.service_account
    scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
  disk_size_gb         = 100
  disk_type            = "pd-ssd"
  auto_delete          = true
  name_prefix          = "gh-runner"
  source_image_family  = var.source_image_family
  source_image_project = var.source_image_project
  startup_script       = var.startup_script
  source_image         = var.source_image
  metadata = merge({
    "secret-id" = google_secret_manager_secret_version.gh-secret-version.name
  }, local.shutdown_script, var.custom_metadata)
  tags = [
    "gh-runner-vm"
  ]
}
/*****************************************
  Runner MIG
 *****************************************/
module "mig" {
  source             = "terraform-google-modules/vm/google//modules/mig"
  version            = "~> 2.0"
  project_id         = var.project_id
  subnetwork_project = var.project_id
  hostname           = local.instance_name
  region             = var.region
  instance_template  = module.mig_template.self_link
  target_size        = var.target_size

  /* autoscaler */
  autoscaling_enabled = true
}
/*****************************************
  FW
 *****************************************/
resource "google_compute_firewall" "http-access" {
  name    = "${local.instance_name}-http"
  project = var.project_id
  network = local.network_name

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["gh-runner-vm"]
}

resource "google_compute_firewall" "ssh-access" {
  name    = "${local.instance_name}-ssh"
  project = var.project_id
  network = local.network_name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["gh-runner-vm"]
}
