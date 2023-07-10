# network rules
resource "azurerm_firewall_network_rule_collection" "fwnetrc" {
  for_each = { for i in var.network_rule_collections : i.name => i }

  name                = format("%s-%s", module.naming.firewall_network_rule_collection.name, each.key)
  azure_firewall_name = var.firewall_name
  resource_group_name = var.resource_group_name
  priority            = each.value.priority
  action              = each.value.action

  dynamic "rule" {
    for_each = each.value.rules
    content {
      name                  = rule.value.name
      source_addresses      = rule.value.source_addresses
      source_ip_groups      = rule.value.source_ip_groups
      destination_addresses = rule.value.destination_addresses
      destination_ip_groups = rule.value.destination_ip_groups
      destination_fqdns     = rule.value.destination_fqdns
      destination_ports     = rule.value.destination_ports
      protocols             = rule.value.protocols
    }
  }
}

# application rules
resource "azurerm_firewall_application_rule_collection" "fwapprc" {
  for_each = { for i in var.application_rule_collections : i.name => i }

  name                = format("%s-%s", module.naming.firewall_application_rule_collection.name, each.key)
  azure_firewall_name = var.firewall_name
  resource_group_name = var.resource_group_name
  priority            = each.value.priority
  action              = each.value.action

  dynamic "rule" {
    for_each = each.value.rules
    content {
      name             = rule.value.name
      source_addresses = rule.value.source_addresses
      source_ip_groups = rule.value.source_ip_groups
      target_fqdns     = rule.value.target_fqdns
      dynamic "protocol" {
        for_each = rule.value.protocols
        content {
          port = protocol.value.port
          type = protocol.value.type
        }
      }
    }
  }
}

# nat rules
resource "azurerm_firewall_nat_rule_collection" "fwnatrc" {
  for_each = { for i in var.nat_rule_collections : i.name => i }

  name                = format("%s-%s", module.naming.firewall_nat_rule_collection.name, each.key)
  azure_firewall_name = var.firewall_name
  resource_group_name = var.resource_group_name
  priority            = each.value.priority
  action              = each.value.action
  dynamic "rule" {
    for_each = each.value.rules
    content {
      name                  = rule.value.name
      source_addresses      = rule.value.source_addresses
      source_ip_groups      = rule.value.source_ip_groups
      destination_ports     = rule.value.destination_ports
      destination_addresses = [var.firewall_public_ip]
      translated_address    = rule.value.translated_address
      translated_port       = rule.value.translated_port
      protocols             = rule.value.protocols
    }
  }
}