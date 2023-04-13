

resource "azurerm_bastion_host" "bastion" {
  name                = "${var.env}-bastion"
  location            = var.resource_location
  resource_group_name = "${var.env}-resource-group"
  sku                 = "Standard"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastion_subnet.id
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }
  depends_on = [
    azurerm_subnet.bastion_subnet
  ]
}