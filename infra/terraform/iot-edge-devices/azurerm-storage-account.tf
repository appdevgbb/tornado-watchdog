# Create storage account & container
# Needed as SA names need to be globally unique and max 12 characters
resource "random_string" "sa_name" {
  length  = 12
  special = false
  upper   = false
}

resource "azurerm_storage_account" "sa" {
  name                     = random_string.sa_name.id
  resource_group_name      = azurerm_resource_group.default.name
  location                 = azurerm_resource_group.default.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "my_terraform_container" {
  name                  = "mycontainer"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}
