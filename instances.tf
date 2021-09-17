
resource "google_compute_instance" "cicd-jumpbox-rampup2" {
  name         = "cicd-jumpbox-rampup2"
  machine_type = "e2-small"
  zone         = var.zone
  project = var.project
  tags = ["public"]

  boot_disk {
    initialize_params {
      image = "ubuntu-2004-focal-v20210908"
    }
  }

  allow_stopping_for_update = false


  network_interface {
    network = google_compute_network.vpc-rampup2.self_link
    subnetwork = "management-subnet-${var.project_type}"

    access_config {
      // Ephemeral public IP
    }
  }
   
}


# resource "google_compute_instance_template" "instance-template-rampup2" {
#   name_prefix  = "instance-template-rampup2"
#   machine_type = "e2-small"
#   region       = var.region

#   // boot disk
#   disk {
#     source_image = "ubuntu-2004-focal-v20210908"
#     boot = true
#   }

#   // networking
#   network_interface {
#     network = google_compute_network.vpc-rampup2.self_link
#     subnetwork = google_compute_subnetwork.kubernetes-subnet-rampup2.self_link

#     access_config {
#       // Ephemeral public IP
#     }
#   }

#   lifecycle {
#     create_before_destroy = true
#   }
# }

# resource "google_compute_instance_group_manager" "master-node-instance_group_manager" {
#   name               = "master-node-instance-group-rampup2"
#   instance_template  = google_compute_instance_template.instance_template-rampup2.id
#   base_instance_name = "instance-group-manager"
#   zone               = var.zone
#   target_size        = "1"
# }

# resource "google_compute_instance_group" "worker-node-instance-group-rampup2" {
#   name        = "worker-node-instance-group-${var.project_type}"
#   description = "Worker node instance group"

#   instances = [
#     google_compute_instance.test.id,
#     google_compute_instance.test2.id,
#   ]

#   named_port {
#     name = "http"
#     port = "8080"
#   }

#   named_port {
#     name = "https"
#     port = "8443"
#   }

#   zone = "us-central1-a"
# }