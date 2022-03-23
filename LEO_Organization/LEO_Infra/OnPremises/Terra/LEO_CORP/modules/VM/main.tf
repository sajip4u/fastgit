

resource "azurerm_network_interface" "nic1" {
  location            = var.location
  name                = "${var.vmname}-NIC1"
  resource_group_name = var.ResourceGroupName
  ip_configuration {
    name                          = "${var.vmname}-Internal"
    private_ip_address_allocation = "dynamic"
    subnet_id                     = var.subnetID
    public_ip_address_id          = azurerm_public_ip.PublicIP1.id
  }


  depends_on = [
    azurerm_public_ip.PublicIP1
  ]

}

resource "azurerm_public_ip" "PublicIP1" {
  name                = "${var.vmname}-PublicIP1"
  resource_group_name = var.ResourceGroupName
  location            = var.location
  allocation_method   = "Dynamic"
}

resource "azurerm_windows_virtual_machine" "VM1" {
  admin_password        = "Ponnu@123456"
  admin_username        = "sajiadm"
  location              = var.location
  name                  = var.vmname
  network_interface_ids = [azurerm_network_interface.nic1.id]
  resource_group_name   = var.ResourceGroupName
  size                  = var.size
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.vm_os_publisher
    offer     = var.vm_os_offer
    sku       = var.vm_os_sku
    version   = var.vm_os_version
  }

  depends_on = [
    azurerm_network_interface.nic1
  ]
}

resource "azurerm_network_security_group" "NSG1" {
  location            = var.location
  name                = "${var.vmname}-NSG1"
  resource_group_name = var.ResourceGroupName
  security_rule = [{
    access                                     = "Allow"
    description                                = "value"
    destination_address_prefix                 = "*"
    destination_address_prefixes               = []
    destination_application_security_group_ids = []
    destination_port_range                     = "3389"
    destination_port_ranges                    = []
    direction                                  = "Inbound"
    name                                       = "RDP3389"
    priority                                   = 100
    protocol                                   = "Tcp"
    source_address_prefix                      = "*"
    source_address_prefixes                    = []
    source_application_security_group_ids      = []
    source_port_range                          = "*"
    source_port_ranges                         = []
  }]
}

resource "azurerm_network_interface_security_group_association" "NICASSOC" {
  network_interface_id      = azurerm_network_interface.nic1.id
  network_security_group_id = azurerm_network_security_group.NSG1.id

  depends_on = [
    azurerm_network_interface.nic1,
    azurerm_network_security_group.NSG1
  ]
}