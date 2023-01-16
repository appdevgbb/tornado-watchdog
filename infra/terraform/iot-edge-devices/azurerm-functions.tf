resource "azurerm_service_plan" "listener" {
  name                = local.name
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location
  os_type             = "Linux"
  sku_name            = "Y1"
}

resource "azurerm_linux_function_app" "listener" {
  name                = local.name
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location

  storage_account_name       = azurerm_storage_account.default.name
  storage_account_access_key = azurerm_storage_account.default.primary_connection_string
  service_plan_id            = azurerm_service_plan.listener.id

  site_config {}
}