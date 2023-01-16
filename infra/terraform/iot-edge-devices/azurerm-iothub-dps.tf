resource "azurerm_iothub_dps" "dps" {
  name                = local.name
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location
  allocation_policy   = "Hashed"

  sku {
    name     = "S1"
    capacity = 1
  }

  linked_hub {
    connection_string       = azurerm_iothub_shared_access_policy.hub_access_policy.primary_connection_string
    location                = azurerm_resource_group.default.location
    allocation_weight       = 150
    apply_allocation_policy = true
  }
}