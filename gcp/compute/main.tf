provider "google" {
  project     = "utkarshtrial"
  credentials = "key.json"
}

module "instancegcp" {
    source = "git::https://github.com/utkarshsingh887/terraform_gcp_trial_project.git"
    instance_name = "trialinstance"
    instance_type = "e2-medium"
    instance_zone =  "us-central1-a"
    instance_image = "debian-cloud/debian-11"
  
}