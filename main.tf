terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.azure_subscription_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id
}

# Generate a random string to make names unique
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

# Resource Group with unique name
resource "azurerm_resource_group" "devops_rg" {
  name     = "devops-proj-rg-${random_string.suffix.result}"
  location = "East US"
}

# Virtual Network
resource "azurerm_virtual_network" "devops_vnet" {
  name                = "devops-vnet-${random_string.suffix.result}"
  location            = azurerm_resource_group.devops_rg.location
  resource_group_name = azurerm_resource_group.devops_rg.name
  address_space       = ["10.0.0.0/16"]
}

# Subnet
resource "azurerm_subnet" "devops_subnet" {
  name                 = "devops-subnet-${random_string.suffix.result}"
  resource_group_name  = azurerm_resource_group.devops_rg.name
  virtual_network_name = azurerm_virtual_network.devops_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Public IP
resource "azurerm_public_ip" "devops_public_ip" {
  name                = "devops-vm-ip-${random_string.suffix.result}"
  location            = azurerm_resource_group.devops_rg.location
  resource_group_name = azurerm_resource_group.devops_rg.name
  allocation_method   = "Static"
}

# Network Interface
resource "azurerm_network_interface" "devops_nic" {
  name                = "devops-nic-${random_string.suffix.result}"
  location            = azurerm_resource_group.devops_rg.location
  resource_group_name = azurerm_resource_group.devops_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.devops_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.devops_public_ip.id
  }
}

# Virtual Machine
resource "azurerm_linux_virtual_machine" "devops_vm" {
  name                = "devops-vm-${random_string.suffix.result}"
  resource_group_name = azurerm_resource_group.devops_rg.name
  location            = azurerm_resource_group.devops_rg.location
  size                = "Standard_B2s"
  admin_username      = "azureuser"
  network_interface_ids = [azurerm_network_interface.devops_nic.id]

  admin_ssh_key {
    username   = "azureuser"
    public_key = var.ssh_public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "16.04.202011120"
  }
}

# Output VM Public IP
output "vm_public_ip" {
  value = azurerm_public_ip.devops_public_ip.ip_address
}

# Output Resource Group Name
output "resource_group_name" {
  value = azurerm_resource_group.devops_rg.name
}