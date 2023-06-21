output "firewall_name" {
  value      = module.hub_vnet.firewall_name
  sensitive  = false
  depends_on = []
}

output "firewall_public_ip" {
  value      = module.hub_vnet.firewall_public_ip
  sensitive  = false
  depends_on = []
}

output "firewall_private_ip" {
  value      = module.hub_vnet.firewall_private_ip
  sensitive  = false
  depends_on = []
}