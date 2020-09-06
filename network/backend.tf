provider "google" {
  project = var.project_id
  region  = var.region
}

terraform {
  backend "gcs" {
    bucket = "starwars-rick-and-morty-apple-juice"
    prefix = "main-network.tfstate"
  }
}