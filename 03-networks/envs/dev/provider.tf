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
  skip_provider_registration = true
  alias                      = "sub-bu1-app1-dev"
  subscription_id            = "1b668524-37b9-410f-aede-fca0b2f2ee06"
  features {}
}