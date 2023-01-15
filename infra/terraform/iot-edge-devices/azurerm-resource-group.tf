resource "azurerm_resource_group" "default" {
  name = "${var.prefix}tornado-iotedge"
  location = var.location
}