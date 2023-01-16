terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
    pkcs12 = {
      source = "chilicat/pkcs12"
    }
  }
}

resource random_string "device_id" {
    length = 8
    special = false
    numeric = false
    upper = false
}

locals {
  device_id = "${var.prefix}${random_string.device_id.id}"
}