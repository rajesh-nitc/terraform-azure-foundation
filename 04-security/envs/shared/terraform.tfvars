env                 = "hub"
location            = "westus"
resource_group_name = "rg-hub"
firewall_name       = "testfirewall"
firewall_public_ip  = ""
network_rule_collections = [
  {
    name     = "RuleCollection1"
    priority = 100
    action   = "Allow"
    rules = [
      {
        name                  = "AllowRule1"
        source_addresses      = ["10.10.1.0/24"]
        destination_ports     = ["22"]
        destination_addresses = ["10.10.2.0/24"]
        protocols             = ["TCP"]
        destination_fqdns     = null
        destination_ip_groups = null
        source_ip_groups      = null
      },
      {
        name                  = "AllowRule2"
        source_addresses      = ["10.10.1.0/24"]
        destination_ports     = ["3389"]
        destination_addresses = ["10.10.2.0/24"]
        protocols             = ["TCP"]
        destination_fqdns     = null
        destination_ip_groups = null
        source_ip_groups      = null
      }
    ]
  }
]


application_rule_collections = [
  {
    name     = "AppRuleCollection1"
    priority = 101
    action   = "Allow"
    rules = [
      {
        name             = "AllowGoogle"
        source_addresses = ["10.10.1.0/24", "10.10.2.0/24"]
        target_fqdns     = ["*.google.com", "*.google.fr"]
        source_ip_groups = null
        protocols = [
          {
            port = "443"
            type = "Https"
          },
          {
            port = "80"
            type = "Http"
          }
        ]
      }
    ]
  }
]

nat_rule_collections = [
  {
    name     = "NatRuleCollection1"
    priority = 100
    action   = "Dnat"
    rules = [
      {
        name               = "RedirectWeb"
        source_addresses   = ["10.0.0.0/16"]
        destination_ports  = ["80"]
        translated_port    = 53
        translated_address = "8.8.8.8"
        protocols          = ["TCP", "UDP"]
        source_ip_groups   = null
      }
    ]
  }
]


 