
#
# virtual machine 1
#

resource "azurerm_linux_virtual_machine" "linux_vm_1" {
  name                            = "${var.env}-machine-1"
  location                        = var.resource_location
  resource_group_name             = "${var.env}-resource-group"
  size                            = "Standard_F1"
  admin_username                  = "adminuser"
  admin_password                  = azurerm_key_vault_secret.linux_vm_1_secret.value
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.v_network_int_1.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}

# #
# # virtual machine 2
# #

# resource "azurerm_linux_virtual_machine" "linux_vm_2" {
#   name                = "${var.env}-machine-2"
# location            = var.resource_location
# resource_group_name = "${var.env}-resource-group"
#   size                = "Standard_F1"
#   admin_username      = "adminuser"
#   admin_password                  = azurerm_key_vault_secret.linux_vm_2_secret.value
#   disable_password_authentication = false
#   network_interface_ids = [
#     azurerm_network_interface.v_network_int_2.id,
#   ]


#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "UbuntuServer"
#     sku       = "16.04-LTS"
#     version   = "latest"
#   }
# }