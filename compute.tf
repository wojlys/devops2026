resource "google_compute_instance" "web" {
  name         = var.machine_name
  machine_type = var.machine_type
  zone         = var.zone
  tags         = ["devops-2026-web"]

  boot_disk {
    initialize_params {
      image = "projects/rocky-linux-cloud/global/images/family/rocky-linux-9"
      size  = 20
      type  = "pd-balanced"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.main.id

    access_config {
      // Ephemeral public IPv4 address.
    }
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    set -euxo pipefail

    dnf install -y httpd
    systemctl enable --now httpd
    printf '%s\n' 'Demo system 1' > /var/www/html/index.html
  EOT

  depends_on = [
    google_project_service.compute
  ]
}

# resource "google_compute_instance" "web_2" {
#   name         = "${var.machine_name}-2"
#   machine_type = var.machine_type
#   zone         = var.zone
#   tags         = ["devops-2026-web"]
#
#   boot_disk {
#     initialize_params {
#       image = "projects/rocky-linux-cloud/global/images/family/rocky-linux-9"
#       size  = 20
#       type  = "pd-balanced"
#     }
#   }
#
#   network_interface {
#     subnetwork = google_compute_subnetwork.main.id
#
#     access_config {
#       // Ephemeral public IPv4 address.
#     }
#   }
#
#   metadata_startup_script = <<-EOT
#     #!/bin/bash
#     set -euxo pipefail
#
#     dnf install -y httpd
#     systemctl enable --now httpd
#     printf '%s\n' 'Demo system 2' > /var/www/html/index.html
#   EOT
#
#   depends_on = [
#     google_project_service.compute
#   ]
# }
#
output "project_number" {
  description = "GCP project number for the existing project."
  value       = data.google_project.current.number
}

output "web_external_ip" {
  description = "Public IP address of the Apache VM."
  value       = google_compute_instance.web.network_interface[0].access_config[0].nat_ip
}

output "web_url" {
  description = "HTTP URL of the Apache VM."
  value       = "http://${google_compute_instance.web.network_interface[0].access_config[0].nat_ip}"
}
