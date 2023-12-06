# Add apim in external mode
resource "azurerm_api_management" "apim" {
  name                = format("%s-%s-%s-%s-%s", module.naming.api_management, var.bu, var.app, var.location, var.env)
  resource_group_name = local.rg_name
  location            = var.location
  publisher_name      = "budita"
  publisher_email     = "rajesh.nitc@gmail.com"

  sku_name                      = "Developer_1"
  public_network_access_enabled = true
  virtual_network_type          = "External"

  virtual_network_configuration {
    subnet_id = data.azurerm_subnet.apim.id
  }

}