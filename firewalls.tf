resource "google_compute_firewall" "rules" {
  project     = "kubernetes-ramp-up"
  name        = "my-firewall-rule"
  network     = "vpc-rampup2"
  description = "Creates firewall rule targeting tagged instances"

  allow {
    protocol  = "tcp"
    ports     = ["80", "8080", "1000-2000"]
  }
  target_tags = ["web"]
}