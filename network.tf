//create the VPC
resource "google_compute_network" "vpc-rampup2" {
  name = "vpc-${var.project_type}"
  auto_create_subnetworks = false
  project = var.project
  
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

//cloud router
resource "google_compute_router" "cloud-router-rampup2" {
  name    ="cloud-router-rampup2"
  region  = google_compute_subnetwork.kubernetes-subnet-rampup2.name
  network = google_compute_network.vpc-rampup2.id

  bgp {
    asn = 64514
  }
}
//cloud nat
resource "google_compute_router_nat" "nat" {
  name                               = "my-router-nat"
  router                             = google_compute_router.cloud-router-rampup2.name
  region                             = google_compute_router.cloud-router-rampup2.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  project                            = var.project
  subnetwork {
    name                             = google_compute_subnetwork.kubernetes-subnet-rampup2.self_link
    source_ip_ranges_to_nat          = "PRIMARY_IP_RANGE"

  } 
  

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}
//load balancer
