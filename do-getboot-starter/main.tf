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
    name  = "boot-starter"
    image = "ubuntu-18-04-x64"
    region = "nyc1"
    size   = "512mb"
    ssh_keys = [
    "${var.ssh_keys}"
    ]

connection {
        user = "root"
        type = "ssh"
        host = "${digitalocean_droplet.web.ipv4_address}"
        private_key = "${file("~/.ssh/id_msa")}"
        timeout = "2m"
    }
    provisioner "remote-exec" {
        inline = [
          "sleep 25",
          "apt-get update",
          "apt-get -y install git",
          "apt-get -y install nginx",
          "git clone https://github.com/stevecosner/getbootstrap-starter.git",
          "cp -r getbootstrap-starter/. /var/www/html"
          
        ]


}


}


output "ip" {
    value = "${digitalocean_droplet.web.ipv4_address}"
}
