resource "google_compute_instance" "server" {
  name         = var.instance_name
  machine_type = var.instance_type
  zone         = var.instance_zone
  boot_disk {
    initialize_params {
      image = var.instance_image
    }
  }
  network_interface {
    network = "default"
  }
}
