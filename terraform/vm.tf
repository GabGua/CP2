  
# Creamos una máquina virtual
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine

#Maquinas tipo B2s
resource "azurerm_linux_virtual_machine" "myVMB2s" {
    count               = length(var.vmsB2s)
    name                = "vms${var.vmsB2s[count.index]}"
    resource_group_name = azurerm_resource_group.rg.name
    location            = azurerm_resource_group.rg.location
    size                = var.vm_sizeB2s
    admin_username      = "adminUsername"
    network_interface_ids = [ azurerm_network_interface.myNic1[count.index].id ]
    disable_password_authentication = true

    admin_ssh_key {
        username   = "adminUsername"
        public_key = file("~/.ssh/id_rsa.pub")
    }

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    plan {
        name      = "centos-8-stream-free"
        product   = "centos-8-stream-free"
        publisher = "cognosys"
    }

    source_image_reference {
        publisher = "cognosys"
        offer     = "centos-8-stream-free"
        sku       = "centos-8-stream-free"
        version   = "1.2019.0810"
    }

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.mystaccount914.primary_blob_endpoint
    }

    tags = {
        environment = "CP2"
    }

}

#Maquinas tipo BD1_v2
resource "azurerm_linux_virtual_machine" "myVMBD1_v2" {
    count               = length(var.vmsBD1_v2)
    name                = "vms${var.vmsBD1_v2[count.index]}"
    resource_group_name = azurerm_resource_group.rg.name
    location            = azurerm_resource_group.rg.location
    size                = var.vm_sizeBD1_v2
    admin_username      = "adminUsername"
    network_interface_ids = [ azurerm_network_interface.myNic2[count.index].id ]
    disable_password_authentication = true

    admin_ssh_key {
        username   = "adminUsername"
        public_key = file("~/.ssh/id_rsa.pub")
    }

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    plan {
        name      = "centos-8-stream-free"
        product   = "centos-8-stream-free"
        publisher = "cognosys"
    }

    source_image_reference {
        publisher = "cognosys"
        offer     = "centos-8-stream-free"
        sku       = "centos-8-stream-free"
        version   = "1.2019.0810"
    }

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.mystaccount914.primary_blob_endpoint
    }

    tags = {
        environment = "CP2"
    }

}
