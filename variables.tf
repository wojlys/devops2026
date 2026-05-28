variable "project_id" {
  description = "Existing GCP project ID where demo infrastructure will be created."
  type        = string
}

variable "region" {
  description = "Default GCP region."
  type        = string
  default     = "europe-central2"
}

variable "zone" {
  description = "Default GCP zone."
  type        = string
  default     = "europe-central2-a"
}

variable "network_name" {
  description = "Name of the VPC network."
  type        = string
  default     = "devops-2026-vpc"
}

variable "subnet_name" {
  description = "Name of the subnet."
  type        = string
  default     = "devops-2026-subnet"
}

variable "subnet_cidr" {
  description = "CIDR range for the subnet."
  type        = string
  default     = "10.10.0.0/24"
}

variable "allowed_ssh_cidrs" {
  description = "CIDR ranges allowed to connect to SSH."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "machine_name" {
  description = "Compute Engine instance name."
  type        = string
  default     = "devops-2026-rocky"
}

variable "machine_type" {
  description = "Compute Engine machine type."
  type        = string
  default     = "e2-micro"
}



