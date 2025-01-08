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
variable "subscription_id" {
  type        = string
  default     = "f936a180-7b93-4203-8faa-f376529bd4f8"  # Use "Windows" for a Windows app
}
variable "client_id" {
  type        = string
  default     = "a2d89136-b086-4755-9f98-af856c2d8c30"  # Use "Windows" for a Windows app
}
variable "client_secret" {
  type        = string
  default     = " "
  }
variable "tenant_id" {
  type        = string
  default     = "13085c86-4bcb-460a-a6f0-b373421c6323"  # Use "Windows" for a Windows app
}
# Define the Key Vault name (assuming Key Vault is created manually)
variable "key_vault_name" {
  description = "The name of the Azure Key Vault"
  type        = string
  default     = "GitHubKVault"  # Name of your manually created Key Vault
}

# Define the name of the secret to store in Key Vault
variable "secret_name" {
  description = "The name of the secret to store in Key Vault"
  type        = string
  default     = "clientsecret1"
}
