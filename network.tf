//create the VPC
resource "google_compute_network" "vpc-rampup2" {
  name = "vpc-${var.project_type}"
  auto_create_subnetworks = "true"
  project = var.project_type

}
// Create Management Subnet
resource "google_compute_subnetwork" "management-subnet-rampup2" {
  project = var.project  
  name          = "management-subnet-${var.project_type}"
  ip_cidr_range = "10.0.1.0/24"
  network       = google_compute_network.vpc-rampup2.id
  region = var.region
}
//Create Kubernetes Subnet
resource "google_compute_subnetwork" "kubernetes-subnet-rampup2" {
  project = var.project  
  name          = "kubernetes-subnet-${var.project_type}"
  ip_cidr_range = "10.0.2.0/24"
  network       = google_compute_network.vpc-rampup2.id
  region = var.region
}