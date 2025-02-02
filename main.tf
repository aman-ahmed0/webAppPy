provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "devops-project-rg"
  location = "East US"
}

resource "azurerm_container_group" "app" {
  name                = "devops-app-container"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  container {
    name   = "app-container"
    image  = "your_dockerhub_username/your_image:latest"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port = 5000
    }
  }

  os_type = "Linux"
}