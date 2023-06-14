terraform {
  required_version = ">= 1.3.1"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.61.0"
    }

  }
}

provider "azurerm" {
  features {}
}

provider "azurerm" {
  skip_provider_registration = true
  alias                      = "common-management"
  subscription_id            = var.subscriptions["common-management"]
  features {}
}