variable "do_token" {}
variable "pub_key" {
  default = "/home/vscode/mydocs/do.pub"
}
variable "pvt_key" {
  default = "/home/vscode/mydocs/do"
}

variable "ssh_fingerprint" {
   default = "36:27:83:ef:65:45:28:5a:5d:bd:59:8a:ac:7d:f7:23"
}

provider "digitalocean" {
  token = "${var.do_token}"
}


resource "digitalocean_droplet" "server" {
  image = "ubutnu"
  name = "kube-worker-${count.index}"
  count = 3
  region = "fra1"
  size = "2gb"
  private_networking = true
  ssh_keys = [
    "${var.ssh_fingerprint}"
  ]
}

resource "null_resource" "configure-server" {
  count = 3
  connection {
      host = "${element(digitalocean_droplet.server.*.ipv4_address, count.index)}"
      user = "rancher"
      type = "ssh"
      private_key = "${file(var.pvt_key)}"
      timeout = "5m"
  }

    provisioner "remote-exec" {
      inline = [
        "docker run -d -p 8080:8080 --restart=unless-stopped ozlevka/syte-server:0.0.1"
      ]
  }

  depends_on = [
       "digitalocean_droplet.server",
  ]
}