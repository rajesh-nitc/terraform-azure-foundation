locals {
  nsg_rules = flatten([
    for i in values(var.snets) : [
      for k, v in coalesce(i.nsg_rules, {}) : {
        nsg_name                   = i.nsg_name
        name                       = v.name
        priority                   = v.priority
        direction                  = v.direction
        access                     = v.access
        protocol                   = v.protocol
        source_port_ranges         = v.source_port_ranges
        destination_port_ranges    = v.destination_port_ranges
        source_address_prefix      = v.source_address_prefix
        destination_address_prefix = v.destination_address_prefix
      }

    ]
  ])

  routes = flatten([
    for i in values(var.snets) : [
      for j in coalesce(i.routes, []) : {
        route_table_name       = i.route_table_name
        route_name             = j.route_name
        address_prefix         = j.address_prefix
        next_hop_type          = j.next_hop_type
        next_hop_in_ip_address = j.next_hop_in_ip_address
      }

    ]
  ])
}
