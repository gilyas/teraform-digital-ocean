provider "digitalocean" {
    token = "PASTE TOKEN HERE"
}
 
resource "digitalocean_droplet" "web" {
    name  = "tf-1"
    image = "ubuntu-18-04-x64"
    region = "nyc1"
    size   = "512mb"
    ssh_keys = [
      "PASTE SSH KEY HERE"
    ]
}
 
output "ip" {
    value = "${digitalocean_droplet.web.ipv4_address}"
}
