provider "google" {
  project = "my-chaos-mesh"
  region  = "us-central1"
  zone    = "us-central1-c"
  credentials = "${file("credentials.json")}"
}

resource "google_compute_instance" "vm_instance" {
  name         = "Terraform-software"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network       = "${google_compute_network.vpc_network.self_link}"
    access_config {
    }
  }
}

resource "google_compute_network" "vpc_network" {
  name                    = "Terraform-network-3"
  auto_create_subnetworks = "true"
}