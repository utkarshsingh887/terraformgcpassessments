resource "google_compute_firewall" "allow_lb" {
  name    = "allow-lb"
  network = var.network_id

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = [
    "130.211.0.0/22",
    "35.191.0.0/16"
  ]

  target_tags = ["web"]
}

resource "google_compute_instance_template" "template" {
  name_prefix  = "web-template-"
  machine_type = "e2-micro"
  tags         = ["web"]

  disk {
    auto_delete  = true
    boot         = true
    source_image = "debian-cloud/debian-12"
  }

  network_interface {
    subnetwork = var.subnet_id
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y nginx
    echo "Hello from PRIVATE VM behind Load Balancer" > /var/www/html/index.html
    systemctl restart nginx
  EOF
}

resource "google_compute_region_instance_group_manager" "mig" {
  name   = "web-mig"
  region = var.region
   base_instance_name = "app"

  version {
    instance_template = google_compute_instance_template.template.id
  }

  target_size = 1
}
