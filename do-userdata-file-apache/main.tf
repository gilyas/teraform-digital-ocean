terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "1.22.2"
    }
  }
  required_version = ">= 0.13"
}



provider "digitalocean" {
    token = "${var.token}"
}

resource "digitalocean_droplet" "web" {
    name  = "testuserdata"
    image = "ubuntu-18-04-x64"
    region = "nyc1"
    size = "512mb"
    user_data  = "${file("web.conf")}"
    ssh_keys = [
    "${var.ssh_keys}"
    ]
}

output "ip" {
    value = "${digitalocean_droplet.web.ipv4_address}"
}