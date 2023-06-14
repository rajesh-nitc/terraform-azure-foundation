location = "westus"

subscriptions = {
  bootstrap-tfstate = "8eba36d1-77ed-4614-9d23-ec86131e8315"
  common-management = "3c624b7d-5bd9-45bb-b1e2-485d05be69c2"
}

mgs = [
  "mg-common",
  "mg-dev",
  "mg-npr",
  "mg-prd"
]

mg_root_display_name = "mg-root"

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