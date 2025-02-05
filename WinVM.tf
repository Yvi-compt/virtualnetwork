/*provider "azurerm" {
  features {}
}*/

resource "azurerm_resource_group" "vmlinuxrg" {
  name     = "virtual-m-linux-resources"
  location = "eastus"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnetwork"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.vmlinuxrg.location
  resource_group_name = azurerm_resource_group.vmlinuxrg.name
}

resource "azurerm_subnet" "subneta" {
  name                 = "subnet-a"
  resource_group_name  = azurerm_resource_group.vmlinuxrg.name
  virtual_network_name = azurerm_virtual_network.vnetwork.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "interfacew" {
  name                = "interface-win-nic"
  location            = azurerm_resource_group.vmlinuxrg.location
  resource_group_name = azurerm_resource_group.vmlinuxrg.name

  ip_configuration {
    name                          = "subnet-a"
    subnet_id                     = azurerm_subnet.subneta.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "winvm" {
  name                = "winvm-machine"
  resource_group_name = azurerm_resource_group.vmlinuxrg.name
  location            = azurerm_resource_group.vmlinuxrg.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.interfacew.id,
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
