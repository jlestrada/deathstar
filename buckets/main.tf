provider "google" {
  credentials = file("~/secrets/gcp-credentials.json")
  project     = var.project
  region      = var.region
}

resource "google_storage_bucket" "state-bucket" {
  name          = "starwars-rick-and-morty-apple-juice"
  location      = "us-west1"
  force_destroy = true
  versioning {
      enabled = true
  }
}