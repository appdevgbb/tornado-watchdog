resource "tls_private_key" "root-key" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P384"
}

resource "tls_self_signed_cert" "root-ca" {
  private_key_pem = tls_private_key.root-key.private_key_pem

  subject {
    common_name  = "ca.${var.prefix}.demo"
    organization = "App Dev Azure Global Black Belt Team"
  }

  is_ca_certificate = true
  # 20 Years :)
  validity_period_hours = 175320

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "cert_signing"
  ]
}

resource "local_file" "rootca" {
  content = tls_self_signed_cert.root-ca.cert_pem
  filename = "certs/iot-hub/rootca/rootca.pem"
}

resource "local_file" "rootkey" {
  content = tls_self_signed_cert.root-ca.private_key_pem
  filename = "certs/iot-hub/rootca/rootkey.pem"
}

# For Demo Only!!! You should verify the certificate in Prod
resource "azurerm_iothub_certificate" "root_ca" {
  name                = "rootca"
  resource_group_name = azurerm_resource_group.default.name
  iothub_name         = azurerm_iothub.default.name
  is_verified         = true

  certificate_content = tls_self_signed_cert.root-ca.cert_pem

  lifecycle {
    ignore_changes = [
      # For some reason it keeps trying to change/modify this value....???
      certificate_content    
    ]
  }
}