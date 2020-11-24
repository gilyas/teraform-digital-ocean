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
### Digital Ocean account to be used on the soon to be created VM.
#resource "digitalocean_ssh_key" "my_ssh_key" {
#  name = "new_ssh_key"
#  public_key = file("~/.ssh/id_rsa.pub")
#}
### If this is used you also need to replace the ssh_keys value for ssh key fingerprint under your 
### droplet resource below with the correct value.
### Example:
### ssh_keys = [
###      digitalocean_ssh_key.default.fingerprint
###    ]


resource "digitalocean_droplet" "web" {
    name  = "tf-1"
    image = "ubuntu-18-04-x64"
    region = "nyc1"
    size   = "512mb"
    ssh_keys = [
      "PASTESSHKEYFINGERPRINTHERE"
    ]
}
 
output "ip" {
    value = "${digitalocean_droplet.web.ipv4_address}"
}
