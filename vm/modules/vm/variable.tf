variable "resource_group_name" {
  description = "The name of the resource group"
}

variable "location" {
  description = "The location/region for the resources"
}

variable "virtual_network_name" {
  description = "The name of the virtual network"
}

variable "address_space" {
  type        = list(string)
  description = "The address space for the virtual network"
}

variable "subnet_name" {
  description = "The name of the subnet"
}

variable "subnet_address_prefix" {
  description = "The address prefix for the subnet"
}

variable "vm_name" {
  description = "The name of the virtual machine"
}

variable "vm_size" {
  description = "The size of the virtual machine"
}

variable "admin_username" {
  description = "The admin username for the virtual machine"
}

variable "admin_password" {
  description = "The admin password for the virtual machine"
  type        = string
  default     = "default-password"  # Set a secure default value
}
