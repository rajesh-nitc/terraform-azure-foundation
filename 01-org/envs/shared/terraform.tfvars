location                         = "westus"
subscription_management_suffix   = "management"
subscription_connectivity_suffix = "connectivity"

allowed_locations = [
  "westus"
]

# group will be created and roles will be assigned to group on root mg
group_roles = {
  "org-admins"      = ["Owner"]
  "security-admins" = ["Security Admin", "User Access Administrator"]
  "network-admins"  = ["Network Contributor"]
  "org-viewer"      = ["Reader"]
}

# Most are commented out to save on costs
log_categories = [
  # "Administrative", 
  "Security",
  "Policy",
  # "ServiceHealth", 
  # "Alert", 
  # "Recommendation", 
  # "Autoscale", 
  # "ResourceHealth"
]

law_solutions = [
  {
    name      = "compliance"
    publisher = "Microsoft"
    product   = "AzurePolicy"
  },
]