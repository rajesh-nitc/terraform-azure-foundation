variable "env" {
  type     = string
  nullable = false
}

variable "bu" {
  type    = string
  default = ""
}

variable "app" {
  type    = string
  default = ""
}

variable "location" {
  type    = string
  default = "westus"
}

variable "enable_nat" {
  description = ""
  type        = bool
  default     = false
}

variable "enable_bastion" {
  description = ""
  type        = bool
  default     = false
}

variable "enable_firewall" {
  description = ""
  type        = bool
  default     = false
}

variable "vnet_address_space" {
  type     = list(string)
  nullable = false
}

variable "snets" {
  description = ""
  type = map(object({
    name                                          = string
    address_prefixes                              = list(string)
    service_endpoints                             = optional(list(string))
    private_endpoint_network_policies_enabled     = optional(bool, true)
    private_link_service_network_policies_enabled = optional(bool, true)

    nsg_name = optional(string)
    nsg_rules = optional(map(object({
      name                       = string
      priority                   = string
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_ranges         = list(string)
      destination_port_ranges    = list(string)
      source_address_prefix      = string
      destination_address_prefix = string
    })))

    route_table_name = optional(string)
    routes = optional(list(object({
      route_name             = string
      address_prefix         = string
      next_hop_type          = string
      next_hop_in_ip_address = optional(string)


    })))
  }))
  default = {}
}

variable "bastion_address_prefixes" {
  type    = list(string)
  default = []
}

variable "firewall_address_prefixes" {
  type    = list(string)
  default = []
}

variable "private_dns_zones" {
  type    = list(string)
  default = []
}


