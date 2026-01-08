provider "google" {
  project     = "utkarshtrial"
  credentials = "key.json"
}


resource "google_compute_network" "vpc" {
  name                    = "private-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "private_subnet" {
  name          = "private-subnet"
  ip_cidr_range = "10.10.0.0/24"
  region        = var.region
  network       = google_compute_network.vpc.id
  private_ip_google_access = true
}


resource "google_compute_router_nat" "nat" {
  name                               = "cloud-nat"
  router                             = google_compute_router.router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
resource "google_compute_router" "router" {
  name    = "nat-router"
  region  = var.region
  network = google_compute_network.vpc.id
}



resource "google_compute_firewall" "allow_lb" {
  name    = "allow-lb"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  target_tags   = ["web"]
}
resource "google_compute_instance_template" "web_template" {
  name_prefix  = "web-template-"
  machine_type = "e2-micro"

  tags = ["web"]

  disk {
    auto_delete  = true
    boot         = true
    source_image = "debian-cloud/debian-12"
  }

  network_interface {
    subnetwork = google_compute_subnetwork.private_subnet.id
    # NO external IP
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y nginx
    echo "Hello from PRIVATE VM behind Load Balancer" > /var/www/html/index.html
    systemctl restart nginx
  EOF
}

resource "google_compute_region_instance_group_manager" "web_mig" {
  name   = "web-mig"
  region = var.region
  base_instance_name = "app"

  version {
    instance_template = google_compute_instance_template.web_template.id
  }

  target_size = 1
}

resource "google_compute_health_check" "http" {
  name = "http-health-check"

  http_health_check {
    port = 80
  }
}

resource "google_compute_backend_service" "backend" {
  name                  = "web-backend"
  protocol              = "HTTP"
  port_name             = "http"
  timeout_sec           = 10
  health_checks         = [google_compute_health_check.http.id]
  load_balancing_scheme = "EXTERNAL"

  backend {
    group = google_compute_region_instance_group_manager.web_mig.instance_group
  }
}

resource "google_compute_url_map" "url_map" {
  name            = "web-url-map"
  default_service = google_compute_backend_service.backend.id
}
resource "google_compute_target_http_proxy" "http_proxy" {
  name    = "http-proxy"
  url_map = google_compute_url_map.url_map.id
}

resource "google_compute_global_forwarding_rule" "http" {
  name       = "http-forwarding-rule"
  target    = google_compute_target_http_proxy.http_proxy.id
  port_range = "80"
}
