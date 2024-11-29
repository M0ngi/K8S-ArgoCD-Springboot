resource "digitalocean_droplet" "www-1" {
  image = "ubuntu-24-10-x64"
  name = "www-1"
  region = "nyc3"
  size = "s-2vcpu-4gb"
  ssh_keys = [
    data.digitalocean_ssh_key.terraform.id
  ]
  
  connection {
    host = self.ipv4_address
    user = "root"
    type = "ssh"
    private_key = file(var.pvt_key)
    timeout = "2m"
  }
  
  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "adduser --disabled-password --gecos '' ansible",
      "adduser ansible sudo",
      "cp /root/.ssh /home/ansible -r",
      "chown ansible:ansible /home/ansible/.ssh",
      "chown ansible:ansible /home/ansible/.ssh/authorized_keys",
      "echo 'ansible ALL=(ALL) NOPASSWD: ALL' | sudo tee /etc/sudoers.d/ansible"
    ]
  }
}