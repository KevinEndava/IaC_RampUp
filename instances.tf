
resource "google_compute_instance" "default" {
  name         = "CICD_Jumpbox"
  machine_type = "e2-small"
  zone         = "us-central1-a"
  project = var.project
  tags = ["web"]

  boot_disk {
    initialize_params {
      image = data.google_compute_image.debian.id
    }
  }

  allow_stopping_for_update = false

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = "vpc-${var.project_type}"
    subnetwork = "management-subnet-${var.project_type}"

    access_config {
      // Ephemeral public IP
    }
  }

 
  metadata_startup_script = "echo hi > /test.txt"

  
}
