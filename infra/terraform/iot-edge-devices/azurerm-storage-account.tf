resource "azurerm_storage_account" "default" {
  name                     = local.name
  resource_group_name      = azurerm_resource_group.default.name
  location                 = azurerm_resource_group.default.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "default" {
  name                  = "mycontainer"
  storage_account_name  = azurerm_storage_account.default.name
  container_access_type = "private"
}
