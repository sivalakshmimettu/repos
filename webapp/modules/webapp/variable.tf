# variables.tf

variable "resource_group_name" {
  description = "The name of the Azure resource group"
  type        = string
  default     = "vam-rg-nov"
}

#variable "location" {
  #description = "The Azure region where resources will be created"
  #type        = string
  #default     = "West US 2"
#}

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
  default     = "QEt8Q~el5WQ8JWv56IsRMvM5mSJeMHsflwyEJbQ7"  # Use "Windows" for a Windows app
}
variable "tenant_id" {
  type        = string
  default     = "13085c86-4bcb-460a-a6f0-b373421c6323"  # Use "Windows" for a Windows app
}
