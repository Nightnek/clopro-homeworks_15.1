resource "yandex_vpc_network" "clopro" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "public" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.clopro.id
  v4_cidr_blocks = var.default_cidr
}

resource "yandex_vpc_subnet" "private" {
  name           = var.vpc_name1
  zone           = var.default_zone
  network_id     = yandex_vpc_network.clopro.id
  v4_cidr_blocks = var.private_cidr
  route_table_id = yandex_vpc_route_table.nat-instance-route.id
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_os_family
}

resource "yandex_vpc_security_group" "nat-instance-sg" {
  name       = var.sg_nat_name
  network_id = yandex_vpc_network.clopro.id

  egress {
    protocol       = "ANY"
    description    = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "ANY"
    description    = "all"
    from_port         = 0
    to_port           = 65535
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}


# resource "yandex_compute_image" "nat-instance-ubuntu" {
#   image_id = var.nat_image
# }

resource "yandex_compute_instance" "public_vm" {
  name        = "public_vm"
  hostname    = "publicvm"
  platform_id = var.vm_platform_id
  allow_stopping_for_update = true
  resources {
    cores = var.vm_cpu_count
    memory = var.vm_ram_count
    core_fraction = var.vm_core_fraction
    
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.public.id
    nat       = var.vm_nat
  }

  metadata = {
    serial-port-enable = 1
    user-data = "${file("~//OneDrive//Documents////Netology//DevOps//k8s//kuber-homeworks_3.2//cloud-config.yaml")}"
  }

}

resource "yandex_compute_instance" "private_vm" {
  name        = "private_vm"
  hostname    = "privatevm"
  platform_id = var.vm_platform_id
  allow_stopping_for_update = true
  resources {
    cores = var.vm_cpu_count
    memory = var.vm_ram_count
    core_fraction = var.vm_core_fraction
    
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.private.id
  }

  metadata = {
    serial-port-enable = 1
    user-data = "${file("~//OneDrive//Documents////Netology//DevOps//k8s//kuber-homeworks_3.2//cloud-config.yaml")}"
  }


}

resource "yandex_compute_instance" "nat-instance" {
  name        = "vm_nat"
  platform_id = var.vm_platform_id
  zone        = var.default_zone

  resources {
    cores = var.vm_cpu_count
    memory = var.vm_ram_count
    core_fraction = var.vm_core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = var.nat_image
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.public.id
    ip_address         = var.nat_int_ip
    security_group_ids = [yandex_vpc_security_group.nat-instance-sg.id]
    nat                = true
  }

  metadata = {
    user-data = "${file("~//OneDrive//Documents////Netology//DevOps//k8s//kuber-homeworks_3.2//cloud-config.yaml")}"
  }
}

resource "yandex_vpc_address" "external_address" {
  name = "external-IP"
  external_ipv4_address {
    zone_id = var.default_zone
  }
}

resource "yandex_vpc_route_table" "nat-instance-route" {
  name       = "nat-instance-route"
  network_id = yandex_vpc_network.clopro.id
  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = yandex_compute_instance.nat-instance.network_interface.0.ip_address
  }
}