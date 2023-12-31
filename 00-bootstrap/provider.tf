terraform {
  required_version = ">= 1.3"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.61.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">=2.39.0"
    }
  }
}

provider "azurerm" {
  storage_use_azuread        = true
  skip_provider_registration = true
  features {}
}

provider "azuread" {
}