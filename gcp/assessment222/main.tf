provider "google" {
project = var.project_id
  credentials = "key.json"
  region  = var.region
}

module "network" {
  source = "./modules/network"
  region = var.region
}

module "nat" {
  source  = "./modules/nat"
  region  = var.region
  network = module.network.vpc_id
}

module "compute" {
  source        = "./modules/compute"
  region        = var.region
  subnet_id     = module.network.subnet_id
  network_id    = module.network.vpc_id
}

module "load_balancer" {
  source              = "./modules/loadbalancer"
  region              = var.region
  instance_group      = module.compute.instance_group
}
