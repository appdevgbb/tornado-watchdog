resource "azurerm_iothub_dps_certificate" "example" {
  name                = "example"
  resource_group_name = var.resource_group.name
  iot_dps_name        = var.iot_dps_name

# This should be set to false for a production environment; you should manually verify the edge device cert
is_verified = true

  certificate_content = tls_locally_signed_cert.client-signed-cert.cert_pem
}