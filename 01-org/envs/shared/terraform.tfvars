location            = "westus"
sub_id_management   = "3c624b7d-5bd9-45bb-b1e2-485d05be69c2"
sub_id_connectivity = "9f75fbbf-3b6c-4036-971d-426b55119ad5"

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