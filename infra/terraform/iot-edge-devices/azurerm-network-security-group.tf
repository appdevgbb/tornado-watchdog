
resource "azurerm_network_security_group" "iot-edge-devices" {
  name                = "iot-edge-devices-nsg"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name

#   security_rule {
#     name                       = "test123"
#     priority                   = 100
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "*"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }
}

resource "azurerm_subnet_network_security_group_association" "iot-edge-devices" {
  subnet_id                 = azurerm_subnet.iot-edge-devices.id
  network_security_group_id = azurerm_network_security_group.iot-edge-devices.id
}