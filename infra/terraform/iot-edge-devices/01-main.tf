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

resource "random_pet" "suffix" {
  prefix = var.prefix
  length = 1
}