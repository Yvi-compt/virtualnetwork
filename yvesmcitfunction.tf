/*resource "azurerm_resource_group" "example" {
  name     = "azure-functions-test-rg"
  location = "West Europe"
}*/

resource "azurerm_storage_account" "yvesmcitstorage" {
  name                     = "functionsapptestsa"
  resource_group_name      = azurerm_resource_group.yvesmcitrg.name
  location                 = azurerm_resource_group.yvesmcitrg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

  resource "azurerm_service_plan" "yvesmcitplan" {
  name                = "yvesmcitplan"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Linux"   # Use "Windows" if needed
  sku_name            = "P1v2"    # Choose the appropriate pricing tier
}

 /* sku {
    tier = "Standard"
    size = "S1"
  }
*/
resource "azurerm_function_app" "yvesmcitfunction" {
  name                       = "test-azure-functions"
  location                   = azurerm_resource_group.yvesmcitrg.location
  resource_group_name        = azurerm_resource_group.yvesmcitrg.name
  app_service_plan_id        = azurerm_service_plan.yvesmcitplan.id
  storage_account_name       = azurerm_storage_account.yvesmcitstorage.name
  storage_account_access_key = azurerm_storage_account.yvesmcitstorage.primary_access_key
}
