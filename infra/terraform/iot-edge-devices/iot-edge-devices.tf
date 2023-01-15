module "iot-edge-devices" {
    source = "./modules/iot-edge-devices"
    
    count = var.iot-edge-device-count

    providers = {
      pkcs12 = pkcs12
     }

    ca_private_key_pem =tls_private_key.root-key.private_key_pem
    ca_cert_pem = tls_self_signed_cert.root-ca.cert_pem 
}