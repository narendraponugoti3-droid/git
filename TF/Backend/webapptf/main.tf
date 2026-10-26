
terraform {
  required_version = ">= 1.12"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 5.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "youruniquestatestorage"
    container_name       = "tfstate"
    key                  = "credprod.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}
