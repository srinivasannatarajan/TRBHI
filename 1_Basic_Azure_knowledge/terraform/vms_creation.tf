# Creating virtual machine No-1
resource "azurerm_linux_virtual_machine" "sriniVM1" {
    name                  = "sriniassgVM1"
    location              = "${var.arm_region}"
    resource_group_name   = azurerm_resource_group.sriniRG.name
    network_interface_ids = [azurerm_network_interface.sriniNIC1.id]
    size                  = "Standard_DS1_v2"

    os_disk {
        name              = "sriniOSDisk1"
        caching           = "ReadWrite"
        storage_account_type = "Premium_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "16.04.0-LTS"
        version   = "latest"
    }

    computer_name  = "sriniVM1"
    admin_username = "srini"
    admin_password = "srini@123"
    disable_password_authentication = false

#    boot_diagnostics {
#        storage_account_uri = azurerm_storage_account.sriniSTORAGEACC1.primary_blob_endpoint
#    }

    tags = {
        environment = "sriniassignment"
    }
}
# Creating virtual machine No-2
resource "azurerm_linux_virtual_machine" "sriniVM2" {
    name                  = "sriniassgVM2"
    location              = "${var.arm_region}"
    resource_group_name   = azurerm_resource_group.sriniRG.name
    network_interface_ids = [azurerm_network_interface.sriniNIC2.id]
    size                  = "Standard_DS1_v2"

    os_disk {
        name              = "sriniOSDisk2"
        caching           = "ReadWrite"
        storage_account_type = "Premium_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "16.04.0-LTS"
        version   = "latest"
    }

    computer_name  = "sriniVM2"
    admin_username = "srini"
    admin_password = "srini@123"
    disable_password_authentication = false

#    boot_diagnostics {
#        storage_account_uri = azurerm_storage_account.sriniSTORAGEACC1.primary_blob_endpoint
#    }

    tags = {
        environment = "sriniassignment"
    }
}

