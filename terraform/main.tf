# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.1"
    }
  }
}

#provider "azurerm" {
## crea un service principal y rellena los siguientes datos para autenticar
#  features {}
#  subscription_id = "28fcfe8a-5f17-4c54-a3db-14d00d3392c0" #var.subscription_id
#  client_id       = "a5e549bf-3ae6-4e26-af32-6145ec79fa95" #var.client_id
#  client_secret   = "T_q5Q~ubgRtcJ5x9jPVMlR4103fl3JWnE9" #var.client_secret
#  tenant_id       = "899789dc-202f-44b4-8472-a6d40f9eb440" #var.tenant_id
#}#

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group

resource "azurerm_resource_group" "rg" {
    name     =  "kubernetes_rg"
    location = var.location

    tags = {
        environment = "CP2"
    }

}

# Storage account
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account

resource "azurerm_storage_account" "stAccount" {
    name                     = var.storage_account 
    resource_group_name      = azurerm_resource_group.rg.name
    location                 = azurerm_resource_group.rg.location
    account_tier             = "Standard"
    account_replication_type = "LRS"

    tags = {
        environment = "CP2"
    }

}

