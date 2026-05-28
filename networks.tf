data "google_project" "current" {
  project_id = var.project_id
}

resource "google_compute_network" "main" {
  name                    = var.network_name
  auto_create_subnetworks = false

  depends_on = [
    google_project_service.compute
  ]
}

resource "google_compute_subnetwork" "main" {
  name          = var.subnet_name
  ip_cidr_range = var.subnet_cidr
  network       = google_compute_network.main.id
  region        = var.region

  depends_on = [
    google_project_service.compute
  ]
}

resource "google_compute_firewall" "ssh" {
  name    = "devops-2026-allow-ssh"
  network = google_compute_network.main.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = var.allowed_ssh_cidrs
  target_tags   = ["devops-2026-web"]

  depends_on = [
    google_project_service.compute
  ]
}

resource "google_compute_firewall" "http" {
  name    = "devops-2026-allow-http"
  network = google_compute_network.main.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["devops-2026-web"]

  depends_on = [
    google_project_service.compute
  ]
}
