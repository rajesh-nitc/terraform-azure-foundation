terraform {
  required_version = ">= 1.3.1"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.61.0"
    }
  }
}

# This is the default provider (i.e. without alias), it will be inherited by the root module automatically
provider "azurerm" {
  skip_provider_registration = true
  subscription_id            = "1b668524-37b9-410f-aede-fca0b2f2ee06"
  features {}
}

provider "azurerm" {
  skip_provider_registration = true
  alias                      = "sub-common-connectivity"
  subscription_id            = "9f75fbbf-3b6c-4036-971d-426b55119ad5"
  features {}
}