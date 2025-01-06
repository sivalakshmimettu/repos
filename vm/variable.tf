# variables.tf

variable "resource_group_name" {
  description = "The name of the Azure resource group"
  type        = string
  default     = "vam-rg-nov"
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
  default     = "West US 2"
}

variable "app_service_plan_name" {
  description = "The name of the App Service Plan"
  type        = string
  default     = "java-springboot-plan"
}

variable "web_app_name" {
  description = "The name of the Web App"
  type        = string
  default     = "java-springboot-jpa-docker-azure"
}

variable "sku_size" {
  description = "The size of the App Service Plan (e.g., B1, S1, P1V2)"
  type        = string
  default     = "B1"  # Example SKU size
}

variable "os_type" {
  description = "The OS type of the App Service Plan"
  type        = string
  default     = "Windows"  # Use "Windows" for a Windows app
}
variable "vm_name" {
  description = "The name of the virtual machine."
  type        = string
}

variable "vm_size" {
  description = "The size of the virtual machine."
  type        = string
}

variable "admin_username" {
  description = "The admin username for the virtual machine."
  type        = string
}

variable "admin_password" {
  description = "The admin password for the virtual machine."
  type        = string
  sensitive   = true
}

// variable "public_ip_name" {
//   description = "The name of the public IP for the VM."
//   type        = string
// }

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
}

variable "subnet_address_prefix" {
  description = "The address prefix for the subnet"
  type        = string
}
variable "virtual_network_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "address_space" {
  description = "The address space for the virtual network"
  type        = list(string)
}
