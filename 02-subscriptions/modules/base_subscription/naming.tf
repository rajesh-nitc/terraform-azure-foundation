module "naming" {
  source = "Azure/naming/azurerm"

  suffix = [var.bu, var.app, var.location, var.env]
}