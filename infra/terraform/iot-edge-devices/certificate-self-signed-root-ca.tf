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