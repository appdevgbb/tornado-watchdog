
resource "azurerm_iothub" "default" {
  name                = local.name
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location

  sku {
    name     = "S1"
    capacity = 1
  }

  cloud_to_device {
    max_delivery_count = 30
    default_ttl        = "PT1H"
    feedback {
      time_to_live       = "PT1H10M"
      max_delivery_count = 15
      lock_duration      = "PT30S"
    }
  }

  tags = {
    purpose = "testing"
  }
}

#Create IoT Hub Access Policy
resource "azurerm_iothub_shared_access_policy" "hub_access_policy" {
  name                = "terraform-policy"
  resource_group_name = azurerm_resource_group.default.name
  iothub_name         = azurerm_iothub.default.name

  registry_read   = true
  registry_write  = true
  service_connect = true
}


resource "azurerm_iothub_endpoint_eventhub" "default" {
  resource_group_name = azurerm_resource_group.default.name
  iothub_id           = azurerm_iothub.default.id
  name                = "eventhub"

  connection_string = azurerm_eventhub_authorization_rule.default.primary_connection_string
}


resource "azurerm_iothub_endpoint_storage_container" "default" {
  resource_group_name = azurerm_resource_group.default.name
  iothub_id           = azurerm_iothub.default.id
  name                = "storage"

  container_name    = azurerm_storage_container.default.name
  connection_string = azurerm_storage_account.default.primary_blob_connection_string

  file_name_format           = "{iothub}/{partition}_{YYYY}_{MM}_{DD}_{HH}_{mm}"
  batch_frequency_in_seconds = 60
  max_chunk_size_in_bytes    = 10485760
  encoding                   = "Avro"
}


resource "azurerm_iothub_route" "storage" {
  name                = azurerm_iothub_endpoint_storage_container.default.name
  resource_group_name = azurerm_resource_group.default.name
  iothub_name         = azurerm_iothub.default.name

  source         = "DeviceMessages"
  condition      = "true"
  endpoint_names = [azurerm_iothub_endpoint_storage_container.default.name]
  enabled        = true
}


resource "azurerm_iothub_route" "eventhub" {
  name                = azurerm_iothub_endpoint_eventhub.default.name
  resource_group_name = azurerm_resource_group.default.name
  iothub_name         = azurerm_iothub.default.name

  source         = "DeviceMessages"
  condition      = "true"
  endpoint_names = [azurerm_iothub_endpoint_eventhub.default.name]
  enabled        = true
}


resource "azurerm_iothub_enrichment" "default" {
  resource_group_name = azurerm_resource_group.default.name
  iothub_name         = azurerm_iothub.default.name
  key                 = "tenant"

  value          = "$twin.tags.Tenant"
  endpoint_names = [
    azurerm_iothub_endpoint_storage_container.default.name,
    azurerm_iothub_endpoint_eventhub.default.name
  ]
}