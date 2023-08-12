resource "azurerm_consumption_budget_management_group" "root" {
  name                = format("%s-%s", "budget", data.azurerm_management_group.root.display_name)
  management_group_id = local.scope

  amount     = var.budget_amount
  time_grain = "Monthly"

  time_period {
    start_date = formatdate("YYYY-MM-01'T'00:00:00Z", timestamp())
  }

  notification {
    enabled        = true
    threshold      = 75.0
    operator       = "GreaterThan"
    threshold_type = "Actual"
    contact_emails = var.budget_contact_emails
  }

  lifecycle {
    ignore_changes = [
      time_period,
    ]
  }
}

resource "azurerm_consumption_budget_subscription" "management" {
  name            = format("%s-%s", "budget", local.sub_name_management)
  subscription_id = local.sub_resource_id_management

  amount     = var.budget_amount
  time_grain = "Monthly"

  time_period {
    start_date = formatdate("YYYY-MM-01'T'00:00:00Z", timestamp())
  }

  notification {
    enabled        = true
    threshold      = 75.0
    operator       = "GreaterThan"
    threshold_type = "Actual"
    contact_emails = var.budget_contact_emails
  }

  lifecycle {
    ignore_changes = [
      time_period,
    ]
  }
}

resource "azurerm_consumption_budget_subscription" "connectivity" {
  name            = format("%s-%s", "budget", local.sub_name_connectivity)
  subscription_id = local.sub_resource_id_connectivity

  amount     = var.budget_amount
  time_grain = "Monthly"

  time_period {
    start_date = formatdate("YYYY-MM-01'T'00:00:00Z", timestamp())
  }

  notification {
    enabled        = true
    threshold      = 75.0
    operator       = "GreaterThan"
    threshold_type = "Actual"
    contact_emails = var.budget_contact_emails
  }

  lifecycle {
    ignore_changes = [
      time_period,
    ]
  }
}