
resource "azurerm_eventhub_namespace" "namespace" {
  name                = random_pet.suffix.id
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location
  sku                 = "Basic"
}

resource "azurerm_eventhub" "my_terraform_eventhub" {
  name                = "myEventHub"
  resource_group_name = azurerm_resource_group.default.name
  namespace_name      = azurerm_eventhub_namespace.namespace.name
  partition_count     = 2
  message_retention   = 1
}

resource "azurerm_eventhub_authorization_rule" "my_terraform_authorization_rule" {
  resource_group_name = azurerm_resource_group.default.name
  namespace_name      = azurerm_eventhub_namespace.namespace.name
  eventhub_name       = azurerm_eventhub.my_terraform_eventhub.name
  name                = "acctest"
  send                = true
}