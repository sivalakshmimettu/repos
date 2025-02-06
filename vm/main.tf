# Configure the Azure provider

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.64.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret  = var.client_secret
  tenant_id      = var.tenant_id
}

# Define the resource group
data "azurerm_resource_group" "example" {
  name     = var.resource_group_name
 }
# Fetch the Azure Key Vault by its name (manual creation of Key Vault)
data "azurerm_key_vault" "example" {
  name                = var.key_vault_name  # Name of the manually created Key Vault
  resource_group_name = data.azurerm_resource_group.example.name
}

# Fetch the secret from Azure Key Vault
data "azurerm_key_vault_secret" "example" {
  name         = var.secret_name  # Name of the secret stored in the Key Vault
  key_vault_id = data.azurerm_key_vault.example.id
}

resource "azurerm_network_security_group" "example" {
  name                = "example-nsg"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.example.name
  
  security_rule {
    name                       = "Allow-SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "203.0.113.0/24"
    destination_address_prefix = "*"
  }

  depends_on = [data.azurerm_resource_group.example]  # Ensure the resource group is created first
}

resource "azurerm_virtual_network" "example" {
  name                = var.virtual_network_name
  location            = var.location
  resource_group_name = data.azurerm_resource_group.example.name
  address_space       = var.address_space

  depends_on = [data.azurerm_resource_group.example]  # Ensure the resource group is created first
}


resource "azurerm_subnet" "example" {
  name                 = var.subnet_name
  address_prefixes     = [var.subnet_address_prefix]  # This should be a list, so wrap it in []
  virtual_network_name = azurerm_virtual_network.example.name
  resource_group_name  = data.azurerm_resource_group.example.name

# Associate the NSG with the subnet
  network_security_group_id = azurerm_network_security_group.example.id
}

resource "azurerm_network_interface" "example" {
  name                = "example-nic"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}

# New Virtual Machine resource
resource "azurerm_virtual_machine" "example" {
  #count               = (var.vm_name != "" && var.vm_size != "") ? 1 : 0
  name                  = var.vm_name
  location              = var.location
  resource_group_name   = data.azurerm_resource_group.example.name
  network_interface_ids = [azurerm_network_interface.example.id]
  vm_size               = var.vm_size

  storage_os_disk {
    name          = "${var.vm_name}-osdisk"
    caching       = "ReadWrite"
    create_option = "FromImage"
    #managed       = true
    os_type       = "Linux"  # Change this to "Windows" for a Windows VM
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_profile {
    computer_name  = var.vm_name
    admin_username = var.admin_username
    admin_password = var.admin_password  # Store this securely
  }

  os_profile_linux_config {
    disable_password_authentication = false  # Set to true if using SSH keys
  }

 
}
