# terraform/main.tf
# Define the resource group
resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}
provider "azurerm" {
  features {}
  subscription_id ="f936a180-7b93-4203-8faa-f376529bd4f8"
  client_id       ="a2d89136-b086-4755-9f98-af856c2d8c30"
  client_secret  = "QEt8Q~el5WQ8JWv56IsRMvM5mSJeMHsflwyEJbQ7"
  tenant_id      = "13085c86-4bcb-460a-a6f0-b373421c6323"
}

module "vm" {
  source = "./modules/vm"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  vm_name                  = var.vm_name
  vm_size                  = var.vm_size
  admin_username           = var.admin_username
  admin_password           = var.admin_password
  #public_ip_name           = var.public_ip_name
  virtual_network_name     = var.virtual_network_name
  #address_space            = var.address_space  # Pass the list directly
  address_space = ["10.0.0.0/16"]
  subnet_name              = var.subnet_name
  subnet_address_prefix    = "10.0.1.0/24"
}
// # Output the web app URL (Make sure the 'webapp' module has an output 'url')
// output "webapp_url" {
//   value = module.webapp.url
// }

// output "vm_url" {
//   value = module.vm.url
// }
