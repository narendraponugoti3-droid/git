
resource "azurerm_resource_group" "credrg" {
  name     = var.rgname
  location = var.location
}

resource "azurerm_service_plan" "credasp" {
  name                = var.asp
  resource_group_name = azurerm_resource_group.credrg.name
  location            = azurerm_resource_group.credrg.location

  os_type  = "Linux"
  sku_name = "B1"
}

resource "azurerm_linux_web_app" "credwebapp" {
  name                = var.webapp
  resource_group_name = azurerm_resource_group.credrg.name
  location            = azurerm_resource_group.credrg.location
  service_plan_id     = azurerm_service_plan.credasp.id

  site_config {
    always_on = false

    application_stack {
      node_version = "22-lts"
    }
  }
}
