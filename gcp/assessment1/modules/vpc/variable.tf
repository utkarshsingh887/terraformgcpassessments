variable "vpc_name" {
    description = "name of vpc network"
    type = string
  
}

variable "region" {
    description = "subnet region"
    type = string
  
}
variable "auto_create_subnetworks" {
    description = "for auto_create_subnetworks"
    type = bool
  
}
variable "ip_cidr_range" {
    description = "for ip_cidr_range"
    type = string
  
}