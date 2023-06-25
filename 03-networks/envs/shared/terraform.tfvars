env                       = "hub"
location                  = "westus"
vnet_address_space        = ["10.0.0.0/18"]
firewall_address_prefixes = ["10.0.0.0/24"]
bastion_address_prefixes  = ["10.0.1.0/24"]
enable_nat                = false
enable_bastion            = true
enable_firewall           = true
snets                     = {}

