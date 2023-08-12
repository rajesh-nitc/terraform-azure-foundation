location                         = "westus"
subscription_management_suffix   = "management"
subscription_connectivity_suffix = "connectivity"

allowed_locations = [
  "westus"
]

# group will be created and roles will be assigned to group on root mg
group_roles = {
  "azure-org-admins"      = ["Owner"]
  "azure-security-admins" = ["Security Admin", "User Access Administrator"]
  "azure-network-admins"  = ["Network Contributor"]
  "azure-org-viewers"     = ["Reader"]
}

logs = [
  {
    "category" : "Administrative",
    "enabled" : true
  },
  {
    "category" : "Policy",
    "enabled" : false
  },
]

law_solutions = [
  # {
  #   name      = "compliance"
  #   publisher = "Microsoft"
  #   product   = "AzurePolicy"
  # },
]

budget_amount = 500
budget_contact_emails = [
  "rajesh.nitc@gmail.com"
]