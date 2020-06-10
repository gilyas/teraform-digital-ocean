# Create ubuntu droplet with user steve with ssh key.

provider "digitalocean" {
    token = "${var.token}"
}




resource "digitalocean_droplet" "web" {
    name  = "doadduser2"
    image = "ubuntu-20-04-x64"
    region = "nyc1"
    size   = "512mb"
    ssh_keys = [
    "${var.ssh_keys}"
    ]

connection {
        user = "root"
        type = "ssh"
        host = "${digitalocean_droplet.web.ipv4_address}"
        private_key = "${file("id_rsa_msa")}"
        timeout = "2m"
}
    provisioner "remote-exec" {
        inline = [
          "sleep 25",
          "useradd steve",
          "mkdir /home/steve",
          "chmod 700 /home/steve",
          "chown steve:steve /home/steve",
          "usermod -s /bin/bash steve",
          "cp .profile /home/steve",
          "cp /etc/skel/.bashrc /home/steve",
          "chown steve:steve /home/steve/.profile",
          "chown steve:steve /home/steve/.bashrc",
          "mkdir /home/steve/.ssh",
          "chmod 700 /home/steve/.ssh",
          "chown steve:steve /home/steve/.ssh",
          "echo 'steve ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers"
          ]
}


    provisioner "file" {
      source      = "id_rsa_msa.pub"
      destination = "/home/steve/.ssh/authorized_keys"
}

    provisioner "remote-exec" {
        inline = [
          "sleep 25",


          "chown steve:steve /home/steve/.ssh/authorized_keys",
          "chmod 600 /home/steve/.ssh/authorized_keys",
          ]
}

}

output "ip" {
    value = "${digitalocean_droplet.web.ipv4_address}"
}