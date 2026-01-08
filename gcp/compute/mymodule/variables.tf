variable "instance_name" {
  type        = string
  description = "The name of the compute instance."
  
}
variable "instance_type" {
  type        = string
  default     = "e2-medium"
  description = "The machine type for the compute instance."
}
variable "instance_zone" {
  type        = string
  description = "The GCP zone to deploy the instance in."
  default = "us-central1-a"
}
variable "instance_image" {
  type        = string
  default     = "debian-cloud/debian-11"
  description = "The OS image to use for the instance."
}
