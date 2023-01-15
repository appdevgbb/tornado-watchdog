output "azurerm_iothub_name" {
  value = azurerm_iothub.iothub.name
}

output "azurerm_iothub_dps_name" {
  value = azurerm_iothub_dps.dps.name
}

output "resource_group_name" {
  value = azurerm_resource_group.default.name
}

output "edge_device_ids" {
    value = module.iot-edge-devices[*].device_id
}