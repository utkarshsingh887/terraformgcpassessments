resource "google_compute_health_check" "hc" {
  name = "http-hc"

  http_health_check {
    port = 80
  }
}

resource "google_compute_backend_service" "backend" {
  name                  = "web-backend"
  protocol              = "HTTP"
  port_name             = "http"
  load_balancing_scheme = "EXTERNAL"
  health_checks         = [google_compute_health_check.hc.id]

  backend {
    group = var.instance_group
  }
}

resource "google_compute_url_map" "url_map" {
  name            = "web-map"
  default_service = google_compute_backend_service.backend.id
}

resource "google_compute_target_http_proxy" "proxy" {
  name    = "http-proxy"
  url_map = google_compute_url_map.url_map.id
}

resource "google_compute_global_forwarding_rule" "rule" {
  name       = "http-forwarding-rule"
  target    = google_compute_target_http_proxy.proxy.id
  port_range = "80"
}
