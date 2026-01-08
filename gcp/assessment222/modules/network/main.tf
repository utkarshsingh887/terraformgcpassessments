resource "google_compute_network" "vpc" {
  name                    = "private-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "private-subnet"
  region        = var.region
  network       = google_compute_network.vpc.id
  ip_cidr_range = "10.0.0.0/24"
  private_ip_google_access = true
}
