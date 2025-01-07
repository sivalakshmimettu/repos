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
  name                = var.GitHubKVault  # Name of the manually created Key Vault
  resource_group_name = data.azurerm_resource_group.example.name
}

# Fetch the secret from Azure Key Vault
data "azurerm_key_vault_secret" "example" {
  name         = var.client_secret  # Name of the secret stored in the Key Vault
  key_vault_id = data.azurerm_key_vault.example.id
}

# Define the Service Plan
resource "azurerm_service_plan" "example" {
  name                = var.app_service_plan_name
  location            = data.azurerm_resource_group.example.location
  resource_group_name = data.azurerm_resource_group.example.name

  # Define SKU attributes directly
  sku_name            = var.sku_size  # This should be the full SKU name, like "B1", "S1", etc.
  os_type             = var.os_type  # "Linux" or "Windows"
}

resource "random_string" "unique" {
  length  = 8
  special = false
  upper   = false
}


# Define the Web App
resource "azurerm_app_service" "example" {
  name                = "${var.web_app_name}-${random_string.unique.result}"
  location            = data.azurerm_resource_group.example.location
  resource_group_name = data.azurerm_resource_group.example.name
  app_service_plan_id = azurerm_service_plan.example.id

  app_settings = {
    "clientsecret1" = data.azurerm_key_vault_secret.example.value
  }
}
