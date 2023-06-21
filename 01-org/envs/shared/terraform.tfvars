location                         = "westus"
subscription_management_suffix   = "management"
subscription_connectivity_suffix = "connectivity"

allowed_locations = [
  "westus"
]

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