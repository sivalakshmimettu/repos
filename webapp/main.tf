# terraform/main.tf
# Reference the existing resource group
data "azurerm_resource_group" "example" {
  name = var.resource_group_name
}
provider "azurerm" {
  features {}
  subscription_id ="f936a180-7b93-4203-8faa-f376529bd4f8"
  client_id       ="a2d89136-b086-4755-9f98-af856c2d8c30"
  client_secret  = "QEt8Q~el5WQ8JWv56IsRMvM5mSJeMHsflwyEJbQ7"
  tenant_id      = "13085c86-4bcb-460a-a6f0-b373421c6323"
}

# Use environment-specific values dynamically
module "webapp" {
  source              = "./modules/webapp"
  web_app_name            = var.web_app_name
  environment         = var.environment
  resource_group_name      = data.azurerm_resource_group.example.name
  location                 = data.azurerm_resource_group.example.location 
  app_service_plan_name = var.app_service_plan_name
}

