output "firewall_name" {
  value = (
    length(var.firewall_address_prefixes) > 0 && var.env == "hub"
    ? azurerm_firewall.firewall[0].name
    : null
  )
  sensitive  = false
  depends_on = []
}

output "firewall_public_ip" {
  value = (
    length(var.firewall_address_prefixes) > 0 && var.env == "hub"
    ? azurerm_public_ip.firewall[0].ip_address
    : null
  )
  sensitive  = false
  depends_on = []
}

output "firewall_private_ip" {
  value = (
    length(var.firewall_address_prefixes) > 0 && var.env == "hub"
    ? azurerm_firewall.firewall[0].ip_configuration[0].private_ip_address
    : null
  )
  sensitive  = false
  depends_on = []
}
