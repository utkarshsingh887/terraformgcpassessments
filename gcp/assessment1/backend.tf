terraform {
  backend "gcs" {
    bucket = "utkarshbucket"
    prefix = "state"
     credentials = "key.json"
    
  }
}