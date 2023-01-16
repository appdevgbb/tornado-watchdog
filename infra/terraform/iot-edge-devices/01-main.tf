terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.39.1"
    }
    pkcs12 = {
      source = "chilicat/pkcs12"
      version = "0.0.7"
    }
  }
}

provider "azurerm" {
  features {
    
  }
}

data "azurerm_subscription" "current" {
}

data "azurerm_client_config" "current" {
}

resource "random_pet" "suffix" {
  length = 1
}

locals {
  name = "${var.prefix}${random_pet.suffix.id}"
}