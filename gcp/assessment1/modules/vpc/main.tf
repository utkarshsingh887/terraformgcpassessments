resource "google_compute_network" "network" {
    name = var.vpc_name
    auto_create_subnetworks = var.auto_create_subnetworks
  
}

resource "google_compute_subnetwork" "subnet" {
    name = "${var.vpc_name}-subnet"
    region = var.region
    network = google_compute_network.network.self_link
    ip_cidr_range = var.ip_cidr_range//"10.0.0.0/24"
  
}