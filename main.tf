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
  name                = var.azurerm_virtual_network
  address_space       = var.address_space
  location            = data.azurerm_resource_group.john-franklin.location
  resource_group_name = data.azurerm_resource_group.john-franklin.name
}

resource "azurerm_subnet" "subnetA" {
  name                 = var.azurerm_subnet
  resource_group_name  = data.azurerm_resource_group.john-franklin.name
  virtual_network_name = var.azurerm_virtual_network
  address_prefixes     = var.address_prefixes
}

resource "azurerm_network_interface" "john-franklin-nic" {
  name                = var.azurerm_network_interface
  location            = data.azurerm_resource_group.john-franklin.location
  resource_group_name = data.azurerm_resource_group.john-franklin.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     =  azurerm_subnet.subnetA.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "john-franklinVM" {
  name                = var.azurerm_windows_virtual_machine
  resource_group_name = data.azurerm_resource_group.john-franklin.name
  location            = data.azurerm_resource_group.john-franklin.location
  size                = "Standard_F2"
  admin_username      = var.admin_username
  admin_password      = var.admin_password
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