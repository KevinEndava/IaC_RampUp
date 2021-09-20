terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.20.0"
    }
  }
}

provider "google" {
  

  project = var.project
  region  = var.region
  zone    = var.zone
}

//Create Master Node Instance Group


