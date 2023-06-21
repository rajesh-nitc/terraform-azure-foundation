module "naming" {
  source = "Azure/naming/azurerm"
  suffix = ["org", "tfstate"]
}

