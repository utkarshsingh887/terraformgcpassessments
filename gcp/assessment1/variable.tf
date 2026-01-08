variable "project_id" {
    description = "project id to deploy"
    type = string
  
}

variable "region" {
    description = "region for vpc and subnetwork"
    type = string
  
}
variable "vpc_name" {
    description = "name of vpc"
    type = string
  
}

variable "ip_cidr_range" {
    description = "ip address of subnetwork"
    type = string
  
}
variable "auto_create_subnetworks" {
    description = "either true or false"
    type = string
  
}
variable "vm_name" {
    description = "the instance name is"
    type = string
  
}
variable "zone" {
    description = "zone of instance"
    type = string
  
}
variable "machine_type" {
    description = "machine type of instance"
    type = string
  
}