###cloud vars
variable "cloud_id" {
  type        = string
  default = "b1gua5vm4htrvegtvhce"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  default = "b1gpf79u52rvts6oo1mn"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["192.168.10.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "private_cidr" {
  type        = list(string)
  default     = ["192.168.20.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "public"
  description = "VPC network&subnet name"
}

variable "vpc_name1" {
  type        = string
  default     = "private"
  description = "VPC network&subnet name"
}

variable "vm_platform_id" {
  type        = string
  default     = "standard-v3"
  description = "Type of platform to use"
}

variable "vm_preemptible" {
  type        = bool
  default     = true
  description = "Could it be stopped or not"
}

variable "vm_os_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "A name of the OS"
}

variable "nat_image" {
  type        = string
  default     = "fd80mrhj8fl2oe87o4e1"
  description = "The number of the OS"
}

variable "vm_name" {
  type        = string
  default     = "netology-develop-platform-kuber"
  description = "A name of the VM"
}
variable "vm_nat" {
  type        = bool
  default     = true
  description = "Should we have nat or not"
}
variable "vm_cpu_count" {
  type        = number
  default     = 2
  description = "count of cpus"
}

variable "vm_ram_count" {
  type        = number
  default     = 1
  description = "value of ram"
}

variable "vm_core_fraction" {
  type        = number
  default     = 20
  description = "core_fraction"
}

variable "nat_int_ip" {
  type        = string
  default     = "192.168.10.254"
  description = "Internal  IP for NAT"
}

variable "sg_nat_name" {
  type        = string
  default     = "nat-instance-sg"
  description = "Name of security group for NAT"
}