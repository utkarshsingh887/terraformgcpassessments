variable "project_id" {
    description = "the project id"
    type = string
  
}
variable "vm_name" {
    description = "the vm name is instance1"
    type = string
 
}
variable "zone" {
    description = "zone is asia-south1-a"
    type = string
  
}
variable "machine_type" {
    description = "instance machine type is"
    type = string
  
}
variable "network_id" {
    description = "the network id is "
    type = string
  
}
variable "subnet_id" {
    description = "the subnet id is"
    type = string
  
}
variable "tags" {
    description = "network tags for instance"
    type = list(string)
    default = []
  
}
variable "boot_image" {
    description = "the  boot image is"
    type = string
    default = "debian-cloud/debian-11"
  
}