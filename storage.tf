resource "azurerm_storage_account" "containers" {
  name                    = var.datalake.name
  resource_group_name     = var.resource_group_name
  location                = var.location
  account_kind             = "StorageV2"
  account_tier             = var.datalake.tier
  account_replication_type = var.datalake.replication_type
  is_hns_enabled = true
  enable_https_traffic_only = true
  min_tls_version           = "TLS1_2"

  identity {
    type = "SystemAssigned"
  }



 
}



resource "azurerm_storage_container" "containers" {
  for_each = toset(var.datalake.containers)

  name               = each.value
  storage_account_name   = azurerm_storage_account.containers.name

  
}
