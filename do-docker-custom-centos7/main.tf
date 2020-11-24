# Create centos7 droplet with docker and docker compose installed.

provider "digitalocean" {
    token = "${var.token}"
}

resource "digitalocean_droplet" "web" {
    name  = "centos-docker-1"
    image = "centos-7-x64"
    region = "nyc1"
    size   = "512mb"
    ssh_keys = [
    "${var.ssh_keys}"
    ]

connection {
        user = "root"
        type = "ssh"
        host = "${digitalocean_droplet.web.ipv4_address}"
        private_key = "${file("C:/Users/Steve/id_rsa")}"
        timeout = "2m"
    }
    provisioner "remote-exec" {
        inline = [
          "sleep 25",
          
          "yum install yum-utils device-mapper-persistent-data lvm2 -y",
          "yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo",
          "yum install docker-ce -y",
          "yum install epel-release -y",
        
          "pip install docker-compose",
          "systemctl start docker"
        ]
    }


}

output "ip" {
    value = "${digitalocean_droplet.web.ipv4_address}"
}
