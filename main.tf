terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  

  project = "kubernetes-ramp-up"
  region  = var.region
  zone    = var.zone
}

//Create Master Node Instance Group


