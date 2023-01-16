resource "azurerm_resource_group" "default" {
  name = "${local.name}-tornado-iotedge"
  location = var.location
}