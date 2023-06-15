location                       = "westus"
shared_resource_naming         = "common"
subscription_management_suffix = "management"
mg_root_display_name           = "mg-root"

allowed_locations = [
  "westus"
]

exempt_vm_ids = [
  # "/subscriptions/<subscription_id>/resourceGroups/<resource_group_name>/providers/Microsoft.Compute/virtualMachines/<vm_name>"
]

exempt_user_object_ids = [
  # "<user_object_id>"
]

law_solutions = [
  {
    name      = "compliance"
    publisher = "Microsoft"
    product   = "AzurePolicy"
  },
]

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