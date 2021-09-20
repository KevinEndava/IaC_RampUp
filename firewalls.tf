# resource "google_compute_firewall" "rules" {
#   project     = var.project
#   name        = "public-firewall-${var.project_type}"
#   network     = "vpc-${var.project_type}"
#   description = "Creates firewall rule targeting tagged instances"

#   allow {
#     protocol  = "tcp"
#     ports     = ["22","80", "8080", "1000-2000"]
#   }
#   target_tags = ["public"]
# }