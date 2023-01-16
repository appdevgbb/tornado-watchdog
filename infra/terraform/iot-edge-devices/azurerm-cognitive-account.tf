# resource "azurerm_role_assignment" "cognitive-services" {
#   scope                = data.azurerm_subscription.current.id
#   role_definition_name = "Cognitive Services Contributor"
#   principal_id         = data.azurerm_client_config.current.object_id
# }

# resource "azurerm_cognitive_account" "default" {
#     depends_on = [
#       azurerm_role_assignment.cognitive-services
#     ]

#   name                = local.name
#   location            = azurerm_resource_group.default.location
#   resource_group_name = azurerm_resource_group.default.name
#   kind                = "TextAnalytics"

#   sku_name = "S0"

#   custom_question_answering_search_service_id = azurerm_search_service.default.id
#   custom_question_answering_search_service_key = azurerm_search_service.default.primary_key
# }


# resource "azurerm_search_service" "default" {
#   name                = "default-search-service"
#   resource_group_name = azurerm_resource_group.default.name
#   location            = azurerm_resource_group.default.location
#   sku                 = "standard"
# }