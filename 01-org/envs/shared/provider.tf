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
  alias                      = "sub-common-management"
  subscription_id            = "3c624b7d-5bd9-45bb-b1e2-485d05be69c2"
  features {}
}