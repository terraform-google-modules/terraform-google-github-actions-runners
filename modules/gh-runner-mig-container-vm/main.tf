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
  dindVolumeMounts = var.dind ? [{
    mountPath = "/var/run/docker.sock"
    name      = "dockersock"
    readOnly  = false
  }] : []
  dindVolumes = var.dind ? [
    {
      name = "dockersock"

      hostPath = {
        path = "/var/run/docker.sock"
      }
  }] : []
  network_name    = var.create_network ? google_compute_network.gh-network[0].self_link : var.network_name
  subnet_name     = var.create_network ? google_compute_subnetwork.gh-subnetwork[0].self_link : var.subnet_name
  service_account = var.service_account == "" ? google_service_account.runner_service_account[0].email : var.service_account
  # location   = var.regional ? var.region : var.zones[0]
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

# allow GCE to pull images from GCR
resource "google_project_iam_binding" "gce" {
  count   = var.service_account == "" ? 1 : 0
  project = var.project_id
  role    = "roles/storage.objectViewer"
  members = [
    "serviceAccount:${local.service_account}",
  ]
}

/*****************************************
  Runner GCE Instance Template
 *****************************************/
locals {
  instance_name = format("%s-%s", var.instance_name, substr(md5(module.gce-container.container.image), 0, 8))
}

module "gce-container" {
  source  = "terraform-google-modules/container-vm/google"
  version = "~> 3.0"
  container = {
    image = var.image
    env = [
      {
        name  = "ACTIONS_RUNNER_INPUT_URL"
        value = var.repo_url
      },
      {
        name  = "GITHUB_TOKEN"
        value = var.gh_token
      },
      {
        name  = "REPO_OWNER"
        value = var.repo_owner
      },
      {
        name  = "REPO_NAME"
        value = var.repo_name
      }
    ]

    # Declare volumes to be mounted
    # This is similar to how Docker volumes are mounted
    volumeMounts = concat([
      {
        mountPath = "/cache"
        name      = "tempfs-0"
        readOnly  = false
      }
    ], local.dindVolumeMounts)
  }

  # Declare the volumes
  volumes = concat([
    {
      name = "tempfs-0"

      emptyDir = {
        medium = "Memory"
      }
    }
  ], local.dindVolumes)

  restart_policy = var.restart_policy
}


module "mig_template" {
  source             = "terraform-google-modules/vm/google//modules/instance_template"
  version            = "~> 8.0"
  project_id         = var.project_id
  region             = var.region
  network            = local.network_name
  subnetwork         = local.subnet_name
  subnetwork_project = var.subnetwork_project != "" ? var.subnetwork_project : var.project_id
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
  source_image_family  = "cos-stable"
  source_image_project = "cos-cloud"
  startup_script       = "export TEST_ENV='hello'"
  source_image         = reverse(split("/", module.gce-container.source_image))[0]
  metadata             = merge(var.additional_metadata, { "gce-container-declaration" = module.gce-container.metadata_value })
  tags = [
    "gh-runner-vm"
  ]
  labels = {
    container-vm = module.gce-container.vm_container_label
  }
}
/*****************************************
  Runner MIG
 *****************************************/
module "mig" {
  source             = "terraform-google-modules/vm/google//modules/mig"
  version            = "~> 8.0"
  project_id         = var.project_id
  subnetwork_project = var.project_id
  hostname           = local.instance_name
  region             = var.region
  instance_template  = module.mig_template.self_link
  target_size        = var.target_size

  /* autoscaler */
  autoscaling_enabled = true
  cooldown_period     = var.cooldown_period
}
