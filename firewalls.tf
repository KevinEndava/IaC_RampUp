resource "google_compute_firewall" "rules" {
  project     = "kubernetes-ramp-up"
  name        = "public-firewall-${var.project_type}"
  network     = "vpc-${var.project_type}"
  description = "Creates firewall rule targeting tagged instances"

  allow {
    protocol  = "tcp"
    ports     = ["80", "8080", "1000-2000"]
  }
  target_tags = ["public"]
}