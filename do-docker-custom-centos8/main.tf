# Create centos8 droplet with docker and docker compose installed.

provider "digitalocean" {
    token = "${var.token}"
}

resource "digitalocean_droplet" "web" {
    name  = "centos-docker-1"
    image = "centos-8-x64"
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
          "dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo",
          "dnf install https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.2.6-3.3.el7.x86_64.rpm -y",
          "dnf install docker-ce -y",
          "dnf install curl -y",
          "curl -L https://github.com/docker/compose/releases/download/1.25.4/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose",
          "chmod +x /usr/local/bin/docker-compose",
          "systemctl start docker"
          
        ]
    }


}

output "ip" {
    value = "${digitalocean_droplet.web.ipv4_address}"
}