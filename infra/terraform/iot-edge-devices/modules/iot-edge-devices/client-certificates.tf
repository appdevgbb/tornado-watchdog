# Create Client Private Key
resource "tls_private_key" "client-key" {
    algorithm   = "ECDSA"
    ecdsa_curve = "P384"
}

# Create CSR
resource "tls_cert_request" "client-csr" {
  private_key_pem = tls_private_key.client-key.private_key_pem

  subject {
    common_name  = local.device_id
    organization = "App Dev Azure Global Black Belt Team"
  }
}

# Sign Client Cert with RootCA
resource "tls_locally_signed_cert" "client-signed-cert" {
  cert_request_pem   = tls_cert_request.client-csr.cert_request_pem
  ca_private_key_pem = var.ca_private_key_pem
  ca_cert_pem        = var.ca_cert_pem

  validity_period_hours = 720

  allowed_uses = [
    "client_auth",
    "ipsec_user"
  ]
}

# PEM Signed Certificate
resource "local_file" "client-signed-cert" {
  content = tls_locally_signed_cert.client-signed-cert.cert_pem
  filename = "certs/iot-hub/edge/client/${local.device_id}.cert.pem.crt"
}

# PEM Private Key
resource "local_file" "client-key" {
  content = tls_private_key.client-key.private_key_pem
  filename = "certs/iot-hub/edge/client/${local.device_id}.private.key"
}

# Convert to PKCS12
resource "pkcs12_from_pem" "client-cert" {
  password = "demopassword123"
  cert_pem = tls_locally_signed_cert.client-signed-cert.cert_pem
  private_key_pem = tls_private_key.client-key.private_key_pem
}

# Write PFX File
resource "local_file" "client-ca-signed-pkcs12-cert" {
  filename = "certs/iot-hub/edge/client/${local.device_id}.client.pfx"
  content_base64 = pkcs12_from_pem.client-cert.result
}