terraform {
  backend "gcs" {
    bucket  = "bucket887"
    prefix  = "private-vm-webserver"
     credentials = "key.json"
  }

  
}
