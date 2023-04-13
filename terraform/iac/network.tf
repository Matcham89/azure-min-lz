#
# network 
#
resource "azurerm_virtual_network" "v_network" {
  name                = "${var.env}-network"
  address_space       = ["192.168.1.0/24"]
  location            = var.resource_location
  resource_group_name = "${var.env}-resource-group"
}

resource "azurerm_subnet" "bastion_subnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = "${var.env}-resource-group"
  virtual_network_name = azurerm_virtual_network.v_network.name
  address_prefixes     = ["192.168.1.224/27"]
}

resource "azurerm_subnet" "vm_subnet" {
  name                 = "${var.env}-subnet"
  resource_group_name  = "${var.env}-resource-group"
  virtual_network_name = azurerm_virtual_network.v_network.name
  address_prefixes     = ["192.168.1.128/27"]
}

resource "azurerm_public_ip" "public_ip" {
  name                = "${var.env}-pub-ip"
  location            = var.resource_location
  resource_group_name = "${var.env}-resource-group"
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "v_network_int_1" {
  name                = "${var.env}-nic-1-${random_id.suffix.hex}"
  location            = var.resource_location
  resource_group_name = "${var.env}-resource-group"
  

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vm_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}