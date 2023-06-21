output "firewall_name" {
  value = (
    var.enable_firewall && var.env == "hub"
    ? azurerm_firewall.firewall[0].name
    : null
  )
  sensitive  = false
  depends_on = []
}

output "firewall_public_ip" {
  value = (
    var.enable_firewall && var.env == "hub"
    ? azurerm_public_ip.firewall[0].ip_address
    : null
  )
  sensitive  = false
  depends_on = []
}

output "firewall_private_ip" {
  value = (
    var.enable_firewall && var.env == "hub"
    ? azurerm_firewall.firewall[0].ip_configuration[0].private_ip_address
    : null
  )
  sensitive  = false
  depends_on = []
}
