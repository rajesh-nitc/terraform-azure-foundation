module "naming" {
  source = "Azure/naming/azurerm"

  suffix = [var.bu, var.app, var.env, var.location]
}

# Error: "name" may only contain alphanumeric characters and dashes and must be between 3-24 chars
module "naming_kv" {
  source = "Azure/naming/azurerm"

  suffix = [var.bu, var.env]
}