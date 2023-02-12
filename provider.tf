#Speicify Provider SDK Connection
terraform {
  required_version = ">=1.3.7"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.42.0"
    }
  }

    #Configure Remote State - Backend - on Azure Storage Account in a separate location away from resources
  backend "azurerm" {
    resource_group_name  = "mec-tfstates-rg"
    storage_account_name = "argocdremotestate"
    container_name       = "tftstateargocddev01"
    key                  = "argocd_dev02.tfstate"
  }

}

provider "azurerm" {
  features {}
}


