
resource "azurerm_eventhub_namespace" "namespace" {
  name                = local.name
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location
  sku                 = "Basic"
}

resource "azurerm_eventhub" "default" {
  name                = local.name
  resource_group_name = azurerm_resource_group.default.name
  namespace_name      = azurerm_eventhub_namespace.namespace.name
  partition_count     = 2
  message_retention   = 1
}

resource "azurerm_eventhub_authorization_rule" "default" {
  resource_group_name = azurerm_resource_group.default.name
  namespace_name      = azurerm_eventhub_namespace.namespace.name
  eventhub_name       = azurerm_eventhub.default.name
  name                = "acctest"
  send                = true
}