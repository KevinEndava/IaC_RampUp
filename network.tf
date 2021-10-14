//create the VPC
resource "google_compute_network" "vpc-network-rampup2" {
  name = "vpc-network-${var.project_type}"
  auto_create_subnetworks = false
  project = var.project
  
}
// Create Management Subnet
resource "google_compute_subnetwork" "management-subnet-rampup2" {
  project = var.project  
  name          = "management-subnet-${var.project_type}"
  ip_cidr_range = "10.0.1.0/24"
  network       = google_compute_network.vpc-network-rampup2.id
  region = var.region
}
//Create Kubernetes Subnet
resource "google_compute_subnetwork" "kubernetes-subnet-rampup2" {
  project = var.project  
  name          = "kubernetes-subnet-${var.project_type}"
  ip_cidr_range = "10.0.2.0/24"
  network       = google_compute_network.vpc-network-rampup2.id
  region = var.region
}

//cloud router
resource "google_compute_router" "cloud-router-rampup2" {
  name    ="cloud-router-rampup2"
  region  = var.region
  network = google_compute_network.vpc-network-rampup2.id

  bgp {
    asn = 64514
  }
}
//cloud nat
resource "google_compute_router_nat" "nat-rampup2" {
  name                               = "router-nat-rampup2"
  router                             = google_compute_router.cloud-router-rampup2.name
  region                             = google_compute_router.cloud-router-rampup2.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  project                            = var.project
  subnetwork {
    name                             = google_compute_subnetwork.kubernetes-subnet-rampup2.self_link
    source_ip_ranges_to_nat          = ["ALL_IP_RANGES"]

  } 
  

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

//public ip for the load balancer

resource "google_compute_global_address" "default" {
  name = "global-appserver-ip"
}

//health check

resource "google_compute_http_health_check" "default" {
  name         = "authentication-health-check"
  request_path = "/health_check"

  timeout_sec        = 1
  check_interval_sec = 1
}

//target pool

resource "google_compute_target_pool" "default" {
  name = "instance-pool"

  instances = [
    "us-central1-a/worker-engine-rampup2-1",
    "us-central1-a/worker-engine-rampup2-1",
  ]

  health_checks = [
    google_compute_http_health_check.default.name,
  ]
}
//load balancer

resource "google_compute_forwarding_rule" "default" {
  name       = "website-forwarding-rule"
  target     = google_compute_target_pool.default.id
  port_range = "32132"
  ip_address = google_compute_global_address.default.id
  
}

