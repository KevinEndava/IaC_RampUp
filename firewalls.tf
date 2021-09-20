resource "google_compute_firewall" "rules" {
  project     = var.project
  name        = "public-firewall-${var.project_type}"
  network     = "vpc-network-${var.project_type}"
  description = "Creates firewall rule targeting tagged instances"

  allow {
    protocol  = "tcp"
    ports     = ["22","80", "8080", "1000-2000"]
  }
  target_tags = ["public"]
}

resource "google_compute_firewall" "fw-allow-lb-rampup2" {
  project     = var.project
  name        = "fw-allow-lb-access"
  network     = "vpc-network-${var.project_type}"
  description = "Creates firewall to allow traffic from sources in the 10.0.1.0/24 and 10.0.2.0/24 ranges. This rule allows traffic from any client located in either of the two subnets."
  source_ranges = [ "10.0.1.0/24, 10.0.2.0/24" ]
  allow {
    protocol  = "tcp"
    ports     = ["22","80", "8080", "1000-2000"]
  }
  target_tags = ["public"]
}