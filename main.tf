terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  

  project = "ultimate-ascent-321720"
  region  = var.region
  zone    = var.zone
}
//create the VPC
resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
  auto_create_subnetworks = "true"
  project = "ultimate-ascent-321720"

}// Create Subnet
resource "google_compute_subnetwork" "subnet1" {
  project = "ultimate-ascent-321720"  
  name          = "subnet1"
  ip_cidr_range = "10.0.3.0/24"
  network       = "terraform-network"
  region = var.region
}

//Create a subnet

resource "google_compute_instance" "vm_instance" {
  name         = var.instance_name
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    subnetwork = google_compute_subnetwork.subnet1.id
    access_config {
    }
  }
}