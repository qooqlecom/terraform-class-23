terraform {
  required_version = ">=0.12"
}
provider "google" {
  region = "us-central1"
}
resource "google_project" "my_project" {
  name            = "gcp-terr"
  project_id      = "project-terr"
  billing_account = "015524-B9BC66-51773F"


}



resource "null_resource" "cluster" {

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "gcloud config set project ${google_project.my_project.project_id}"
  }
}





resource "google_compute_instance" "default" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }

  metadata_startup_script = file("httpd.sh")


  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }

  }
}

resource "google_compute_firewall" "rules" {
  project = google_project.my_project.project_id
  name    = "my-firewall-rule"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "22"]
  }
  source_ranges = ["0.0.0.0/0"]
  source_tags   = ["foo"]
  target_tags   = ["foo"]
}