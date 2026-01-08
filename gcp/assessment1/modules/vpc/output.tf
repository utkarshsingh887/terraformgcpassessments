output "network_id" {
    description = "the selflink of the vpc network"
    value = google_compute_network.network.self_link
  
}

output "subnet_id" {
    description = "self link for subnet"
    value = google_compute_subnetwork.subnet.self_link
  
}