terraform {
  required_version = ">= 1.3"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.61.0"
    }
  }
}

provider "azurerm" {
  use_oidc                   = true
  skip_provider_registration = true
  subscription_id            = "1b668524-37b9-410f-aede-fca0b2f2ee06"
  storage_use_azuread        = true
  features {}
}
