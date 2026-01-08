module "vpc" {
    source = "git::assessment1/vm"
    vpc_name = var.vpc_name
    region = var.region
    ip_cidr_range = var.ip_cidr_range
    auto_create_subnetworks = var.auto_create_subnetworks
  
}

module "vm" {
    source = "./modules/vm"
    project_id = var.project_id
    vm_name = var.vm_name
    zone = var.zone
    machine_type = var.machine_type
    network_id = module.vpc.network_id
    subnet_id = module.vpc.subnet_id
    tags = ["hey", "you"]
    boot_image = "debian-cloud/debian-11"
  
}