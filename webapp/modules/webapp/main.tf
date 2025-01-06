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
    "WEBSITE_NODE_DEFAULT_VERSION" = "14"
  }
}
