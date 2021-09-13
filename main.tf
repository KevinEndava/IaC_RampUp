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
//create the VPC
resource "google_compute_network" "vpc-rampup2" {
  name = "vpc-rampup2"
  auto_create_subnetworks = "true"
  project = "kubernetes-ramp-up"

}
// Create Management Subnet
resource "google_compute_subnetwork" "management-subnet-rampup2" {
  project = "kubernetes-ramp-up"  
  name          = "management-subnet-rampup2"
  ip_cidr_range = "10.0.1.0/24"
  network       = "vpc-rampup2"
  region = var.region
}
//Create Kubernetes Subnet
resource "google_compute_subnetwork" "kubernetes-subnet-rampup2" {
  project = "kubernetes-ramp-up"  
  name          = "kubernetes-subnet-rampup2"
  ip_cidr_range = "10.0.2.0/24"
  network       = "vpc-rampup2"
  region = var.region
}

//Create Master Node Instance Group

resource "google_compute_instance" "vm_instance" {
  name         = var.instance_name
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = data.google_compute_image.my_image.self_link
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    subnetwork = google_compute_subnetwork.management-subnet-rampup2.id
    access_config {
    }
  }
}

//Create Master Node Instance Group
resource "google_compute_instance_group" "webservers" {
  name        = "terraform-webservers"
  description = "Terraform test instance group"

  instances = [
    google_compute_instance.test.id,
    google_compute_instance.test2.id,
  ]

  named_port {
    name = "http"
    port = "8080"
  }

  named_port {
    name = "https"
    port = "8443"
  }

  zone = var.zone
}