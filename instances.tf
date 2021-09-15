
resource "google_compute_instance" "default" {
  name         = "cicd-jumpbox-rampup2"
  machine_type = "e2-small"
  zone         = "us-central1-a"
  project = var.project
  tags = ["web"]

  boot_disk {
    initialize_params {
      image = "ubuntu-2004-focal-v20210908"
    }
  }

  allow_stopping_for_update = false

  // Local SSD disk
 

  network_interface {
    network = "vpc-${var.project_type}"
    subnetwork = "management-subnet-${var.project_type}"

    access_config {
      // Ephemeral public IP
    }
  }

 
  metadata_startup_script = "echo hi > /test.txt"

  
}
