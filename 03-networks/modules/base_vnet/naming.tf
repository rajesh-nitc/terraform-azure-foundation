module "naming" {
  source = "Azure/naming/azurerm"

  suffix = concat(
    var.env != "hub"
    ? [var.bu, var.app]
    : [],
    [var.location, var.env]
  )
}