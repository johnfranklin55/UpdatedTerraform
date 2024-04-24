terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.99.0"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = "true"
    features {
      resource_group {
        prevent_deletion_if_contains_resources = "true"
        }
    }
}

data "azurerm_resource_group" "john-franklin" {
  name = "john-franklin"
}


resource "azurerm_virtual_network" "john-franklin-vnet" {
  name                = "john-franklin-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.john-franklin.location
  resource_group_name = data.azurerm_resource_group.john-franklin.name
}

resource "azurerm_subnet" "subnetA" {
  name                 = "subnetA"
  resource_group_name  = data.azurerm_resource_group.john-franklin.name
  virtual_network_name = azurerm_virtual_network.john-franklin-vnet.name
  address_prefixes     = ["10.0.0.0/20"]
}

resource "azurerm_network_interface" "john-franklin-nic" {
  name                = "john-franklin-nic"
  location            = data.azurerm_resource_group.john-franklin.location
  resource_group_name = data.azurerm_resource_group.john-franklin.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     =  azurerm_subnet.subnetA.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "john-franklinVM" {
  name                = "john-franklinVM"
  resource_group_name = data.azurerm_resource_group.john-franklin.name
  location            = data.azurerm_resource_group.john-franklin.location
  size                = "Standard_F2"
  admin_username      = "johnfrank"
  admin_password      = "Oghenerunor@55"
  network_interface_ids = [
    azurerm_network_interface.john-franklin-nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}