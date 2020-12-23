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
    token = "PASTETOKEN"
}


### Use this resource if copying an ssh key from your PC to your 
### Digital Ocean account.
#resource "digitalocean_ssh_key" "my_ssh_key" {
#  name = "new_ssh_key"
#  public_key = file("~/.ssh/id_rsa.pub")
#}

### Use resources below to create a new SSH key to be copied to your account.

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "digitalocean_ssh_key" "ssh" {
  name = "PrivateMachine"
  public_key = tls_private_key.ssh.public_key_openssh
}

output "ssh_private_key_pem" {
  value = tls_private_key.ssh.private_key_pem
}

output "ssh_public_key_pem" {
  value = tls_private_key.ssh.public_key_pem
}
