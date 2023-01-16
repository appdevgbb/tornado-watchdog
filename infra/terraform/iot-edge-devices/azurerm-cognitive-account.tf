# resource "azurerm_cognitive_account" "default" {
#   name                = local.name
#   location            = azurerm_resource_group.default.location
#   resource_group_name = azurerm_resource_group.default.name
#   kind                = "TextAnalytics"

#   sku_name = "S"

#   custom_question_answering_search_service_id = azurerm_search_service.default.id
#   custom_question_answering_search_service_key = azurerm_search_service.default.primary_key
# }


# resource "azurerm_search_service" "default" {
#   name                = local.name
#   resource_group_name = azurerm_resource_group.default.name
#   location            = azurerm_resource_group.default.location
#   sku                 = "standard"
# }