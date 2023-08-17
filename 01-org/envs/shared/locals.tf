locals {
  scope                        = data.azurerm_management_group.root.id
  sub_resource_id_management   = "/subscriptions/${var.sub_id_management}"
  sub_resource_id_connectivity = "/subscriptions/${var.sub_id_connectivity}"

  group_roles = flatten([
    for k, v in var.group_roles : [
      for i in v : { member = k, role = i }
    ]
  ])
}

