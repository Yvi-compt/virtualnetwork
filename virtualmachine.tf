/*resource "azurerm_resource_group" "vmlinuxrg" {
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
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "netinterface" {
  name                = "net-interface-nic"
  location            = azurerm_resource_group.vmlinuxrg.location
  resource_group_name = azurerm_resource_group.vmlinuxrg.name

  ip_configuration {
    name                          = "subnet-a"
    subnet_id                     = azurerm_subnet.subneta.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vmlinux" {
  name                = "virtual-machine-linux"
  resource_group_name = azurerm_resource_group.vmlinuxrg.name
  location            = azurerm_resource_group.vmlinuxrg.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.netinterface.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
*/
