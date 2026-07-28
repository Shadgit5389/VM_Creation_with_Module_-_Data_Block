terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.80.0"
    }
  }
  # backend "azurerm" {
  #   resource_group_name  = "Dev-shadRG1"
  #   storage_account_name = "devshadstg"
  #   container_name       = "tfstate"
  #   key                  = "dev.tfstate"
  # }
}
provider "azurerm" {
  features {}

}