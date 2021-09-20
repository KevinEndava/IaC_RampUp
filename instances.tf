# //cicd machine
# resource "google_compute_instance" "default" {
#   name         = "cicd-jumpbox-rampup2"
#   machine_type = "e2-small"
#   zone         = var.zone
#   project = var.project
#   tags = ["public"]

#   boot_disk {
#     initialize_params {
#       image = "ubuntu-2004-focal-v20210908"
#     }
#   }

#   allow_stopping_for_update = false


#   network_interface {
#     network = google_compute_network.vpc-rampup2.self_link
#     subnetwork = google_compute_subnetwork.management-subnet-rampup2.self_link

#     access_config {
#       // Ephemeral public IP
#     }
#   }
   
# }

# //First Master machine

# resource "google_compute_instance" "master-engine-rampup2-1" {
#   name         = "master-engine-rampup2-1"
#   machine_type = "e2-small"
#   zone         = var.zone
#   project = var.project
#   tags = ["public"]

#   boot_disk {
#     initialize_params {
#       image = "ubuntu-2004-focal-v20210908"
#     }
#   }

#   allow_stopping_for_update = false


#   network_interface {
#     network = google_compute_network.vpc-rampup2.self_link
#     subnetwork = google_compute_subnetwork.kubernetes-subnet-rampup2.self_link

    
#   }
   
# }

# //First Master machine

# resource "google_compute_instance" "master-engine-rampup2-2" {
#   name         = "master-engine-rampup2-2"
#   machine_type = "e2-small"
#   zone         = var.zone
#   project = var.project
#   tags = ["public"]

#   boot_disk {
#     initialize_params {
#       image = "ubuntu-2004-focal-v20210908"
#     }
#   }

#   allow_stopping_for_update = false


#   network_interface {
#     network = google_compute_network.vpc-rampup2.self_link
#     subnetwork = google_compute_subnetwork.kubernetes-subnet-rampup2.self_link
    
#   }
   
# }

# // Worker machine 1

# resource "google_compute_instance" "worker-engine-rampup2-1" {
#   name         = "worker-engine-rampup2-1"
#   machine_type = "e2-small"
#   zone         = var.zone
#   project = var.project
#   tags = ["public"]

#   boot_disk {
#     initialize_params {
#       image = "ubuntu-2004-focal-v20210908"
#     }
#   }

#   allow_stopping_for_update = false


#   network_interface {
#     network = google_compute_network.vpc-rampup2.self_link
#     subnetwork = google_compute_subnetwork.kubernetes-subnet-rampup2.self_link

    
#   }
   
# }

# // Worker machine 2

# resource "google_compute_instance" "worker-engine-rampup2-2" {
#   name         = "worker-engine-rampup2-2"
#   machine_type = "e2-small"
#   zone         = var.zone
#   project = var.project
#   tags = ["public"]

#   boot_disk {
#     initialize_params {
#       image = "ubuntu-2004-focal-v20210908"
#     }
#   }

#   allow_stopping_for_update = false


#   network_interface {
#     network = google_compute_network.vpc-rampup2.self_link
#     subnetwork = google_compute_subnetwork.kubernetes-subnet-rampup2.self_link

    
#   }
   
# }



# // Unmanaged worker node instance group

# resource "google_compute_instance_group" "worker-node-instance-group-rampup2" {
#   name        = "worker-node-instance-group-${var.project_type}"
#   description = "Worker node instance group"

#   instances = [
#     google_compute_instance.worker-engine-rampup2-1.id,
#     google_compute_instance.worker-engine-rampup2-2.id,
#   ]

#   named_port {
#     name = "http"
#     port = "8080"
#   }

#   named_port {
#     name = "https"
#     port = "8443"
#   }

#   zone = var.zone
# }

# // Unmanaged master node instance group

# resource "google_compute_instance_group" "master-node-instance-group-rampup2" {
#   name        = "master-node-instance-group-${var.project_type}"
#   description = "Master node instance group"

#   instances = [
#     google_compute_instance.master-engine-rampup2-1.id,
#     google_compute_instance.master-engine-rampup2-2.id,
#   ]
#   # access_config {
#   #   nat_ip =google_compute_router_nat.ip

#   # }

#   named_port {
#     name = "http"
#     port = "8080"
#   }

#   named_port {
#     name = "https"
#     port = "8443"
#   }

#   zone = var.zone
# }
# resource "google_compute_instance_template" "instance_template-rampup2" {
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
#     network = "vpc-${var.project_type}"
#     subnetwork = "kubernetes-subnet-${var.project_type}"

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

