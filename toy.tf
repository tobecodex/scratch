provider "azurerm" {
}

resource "azurerm_resource_group" "rg" {
        name = "toy"
        location = "uksouth"
}

resource "azurerm_storage_account" "toy_stroage" {
  name                     = "toystorage"
  resource_group_name      = "${azurerm_resource_group.rg.name}"
  location                 = "${azurerm_resource_group.rg.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_app_service_plan" "sp" {
  name                = "UKSouthFree"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_function_app" "ToyFn" {
  name                      = "input"
  location                  = "${azurerm_resource_group.toy.location}"
  resource_group_name       = "${azurerm_resource_group.toy.name}"
  app_service_plan_id       = "${azurerm_app_service_plan.toy.id}"
  storage_connection_string = "${azurerm_storage_account.toy.primary_connection_string}"
}
