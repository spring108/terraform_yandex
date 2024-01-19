terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}


# provider properties
provider "yandex" {
  #my autorization tocken
  token     = "MY_YANDEX_TOKEN"

  #my yandex cloud identifier
  cloud_id  = "b1gogrmv0lhpqnt6hqu1"

  #my yandex folder identifier (default)
  folder_id = "b1g5ks1opqq9pgacsaoo"

  # YANDEX ZONE: ru-central1-a, ru-central1-b, ru-central1-d
  zone = "ru-central1-a"
}




#############################################################
### VM1
#############################################################
# vm-1 resource configurations
resource "yandex_compute_instance" "vm-1" {
  name = "my_vm1"
  allow_stopping_for_update = true
  resources {
    cores  = 1
    memory = 2
  }
  boot_disk {
    disk_id = yandex_compute_disk.ubuntu2004_15GB.id
  }
  network_interface {
    subnet_id = "e9buvssk2htbkq921avo"
    nat       = true
  }
  metadata = {
    user-data = "${file("./users.yml")}" #user public ssh-authorized-keys in file
  }
  scheduling_policy {
    preemptible = true 
  }
  # init VM -------------------------
  connection {
    type     = "ssh"
    user     = "user"
    private_key = file("./private_key.ppk")
    host = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
  }
  #provisioner "file" {
  #  source      = "./local_file"
  #  destination = "/tmp/remote_file"
  #}
  provisioner "remote-exec" {
    inline = [
      "sudo apt update", 
      "sudo apt-get update", 
      "sudo apt install mc -y",
    ]
  }

}



#############################################################
### TEMPLATES
#############################################################
# boot disk template = ubuntu 20.04 with 15GB
resource "yandex_compute_disk" "ubuntu2004_15GB" {
  name     = "my_ssd_disk"
  type     = "network-ssd"
  zone     = "ru-central1-a"
  #"ubuntu-2004-lts"
  image_id = "ubuntu-16.04-v20180727"
  size = 15
}




