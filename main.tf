resource "random_integer" "suffix" {
  min = 100
  max = 999
}

locals {
  resource_group_name = "rg-${var.organisation}-${var.environment}-${var.workload}-${var.location}-${var.resource_group_name}-${random_integer.suffix.result}"
}

resource "azurerm_resource_group" "this" {
  name     = local.resource_group_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_management_lock" "primary_lock" {
  count      = var.lock_level_value == "" ? 0 : 1
  name       = "${local.resource_group_name}-level-lock"
  scope      = azurerm_resource_group.this.id
  lock_level = var.lock_level_value
  notes      = var.notes
}