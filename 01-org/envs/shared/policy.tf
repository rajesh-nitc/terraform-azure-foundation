locals {
  policy_definition_scope = data.azurerm_management_group.root.id
  policy_assignment_scope = local.policy_definition_scope
}

# allowed_locations
resource "azurerm_policy_definition" "allowed_locations" {
  name                = "allowed-locations-policy"
  display_name        = "Allowed Locations Policy"
  description         = "Restricts the locations where Azure resources can be deployed."
  policy_type         = "Custom"
  mode                = "Indexed"
  management_group_id = local.policy_definition_scope
  policy_rule = jsonencode(
    {
      "if" : {
        "not" : {
          "field" : "location",
          "in" : var.allowed_locations
        }
      },
      "then" : {
        "effect" : "deny"
      }
    }
  )
}

resource "azurerm_management_group_policy_assignment" "allowed_locations_assignment" {
  name                 = "allowed-locations"
  display_name         = "Allowed Locations Assignment"
  description          = "Applies the Allowed Locations policy to the management group"
  policy_definition_id = azurerm_policy_definition.allowed_locations.id
  management_group_id  = local.policy_assignment_scope
}

# deny_vm_external_ip based on tag on vm
resource "azurerm_policy_definition" "deny_vm_external_ip" {
  name                = "deny-vm-external-ip-policy"
  display_name        = "Deny Virtual Machines with External IP Policy"
  description         = "Denies the creation of virtual machines with assigned external IP addresses, except for exempted VMs."
  policy_type         = "Custom"
  mode                = "Indexed"
  management_group_id = local.policy_definition_scope
  policy_rule = jsonencode({
    "if" : {
      "allOf" : [
        {
          "field" : "Microsoft.Network/networkInterfaces/ipConfigurations[*].publicIpAddress.id",
          "exists" : "true"
        },
        {
          "not" : {
            "field" : "tags['exception']",
            "equals" : "true"
          }
        },
        {
          "not" : {
            "field" : "name",
            "in" : var.exempt_vm_ids
          }
        }
      ]
    },
    "then" : {
      "effect" : "deny"
    }
  })
}

resource "azurerm_management_group_policy_assignment" "deny_vm_external_ip_assignment" {
  name                 = "deny-vm-external-ip"
  display_name         = "Deny VMs with External IP Assignment"
  description          = "Applies the Deny Virtual Machines with External IP policy to the management group"
  policy_definition_id = azurerm_policy_definition.deny_vm_external_ip.id
  management_group_id  = local.policy_assignment_scope
}

# deny_user_role_assignment
resource "azurerm_policy_definition" "deny_user_role_assignment" {
  name                = "deny-user-role-assignment-policy"
  display_name        = "Deny User Role Assignment Policy"
  description         = "Denies the creation of any role assignment for a user, except for exempted users."
  policy_type         = "Custom"
  mode                = "Indexed"
  management_group_id = local.policy_definition_scope
  policy_rule = jsonencode({
    "if" : {
      "allOf" : [
        {
          "field" : "Microsoft.Authorization/roleAssignments/principalType",
          "equals" : "User"
        },
        {
          "not" : {
            "field" : "Microsoft.Authorization/roleAssignments/principalId",
            "in" : var.exempt_user_object_ids
          }
        }
      ]
    },
    "then" : {
      "effect" : "deny"
    }
  })
}

resource "azurerm_management_group_policy_assignment" "deny_user_role_assignment_assignment" {
  name                 = "deny-user-role"
  display_name         = "Deny User Role Assignment Assignment"
  description          = "Applies the Deny User Role Assignment policy to enforce IAM assignments for groups only"
  policy_definition_id = azurerm_policy_definition.deny_user_role_assignment.id
  management_group_id  = local.policy_assignment_scope
}