terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "terraform-backend-rg"
    storage_account_name = "terraformbackendstorage"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.azure_subscription_id  # Retrieved from Azure
  client_id       = var.azure_client_id        # Matches "appId"
  client_secret   = var.azure_client_secret    # Matches "password"
  tenant_id       = var.azure_tenant_id        # Matches "tenant"
}


resource "azurerm_resource_group" "devops_rg" {
  name     = "devops-project-rg"
  location = "East US"
}

resource "azurerm_container_group" "devops_app" {
  name                = "devops-app-container"
  location            = azurerm_resource_group.devops_rg.location
  resource_group_name = azurerm_resource_group.devops_rg.name
  os_type             = "Linux"

  container {
    name   = "devops-app"
    image  = "yourdockerhubusername/yourimage:latest"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 5000
      protocol = "TCP"
    }
  }

  dns_name_label = "devops-app-${random_string.suffix.result}"
}

resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}


output "container_public_ip" {
  value = azurerm_container_group.devops_app.ip_address
}
