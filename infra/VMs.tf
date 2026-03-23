resource "azurerm_network_interface" "nic" {
  for_each            = var.vms
  name                = each.value.nic
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = each.value.ip_configuration
    subnet_id                     = azurerm_subnet.subnets[each.value.subnet].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.vm_pip[each.key].id
  }
}

resource "azurerm_linux_virtual_machine" "linux_VM" {
  for_each            = var.vms
  name                = each.key
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = each.value.vm_size
  admin_username      = "adminuser"
  network_interface_ids = [
  azurerm_network_interface.nic[each.key].id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("${path.module}/ssh/id_rsa.pub")
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

resource "azurerm_public_ip" "vm_pip" {
  for_each            = var.vms
  name                = "${each.key}-pip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  allocation_method   = "Static"
  sku                 = "Standard"
}
