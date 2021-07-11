# Creación de la red kubernetes
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network
resource "azurerm_virtual_network" "myNet" {
    name                = "kubernetesnet"
    address_space       = ["10.0.0.0/16"]
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    tags = {
        environment = "CP2"
    }
}

# Creación de la subnet kubernetes
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet
resource "azurerm_subnet" "mySubnet" {
    name                   = "terraformsubnet"
    resource_group_name    = azurerm_resource_group.rg.name
    virtual_network_name   = azurerm_virtual_network.myNet.name
    address_prefixes       = ["10.0.1.0/24"]

}

########## Master node ##########

# Creamos la tarjeta de Red del Master Node
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface
resource "azurerm_network_interface" "myNic1" {
  name                = "vmnic${var.vmsB2s[count.index]}"
  count               = length(var.vmsB2s)
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
    name                           = "myipconfiguration${var.vmsB2s[count.index]}"
    subnet_id                      = azurerm_subnet.mySubnet.id 
    private_ip_address_allocation  = "Static"
    private_ip_address             = "10.0.1.${count.index + 10}"
    public_ip_address_id           = azurerm_public_ip.myPublicIp1[count.index].id
  }

    tags = {
        environment = "CP2"
    }

}

# Le asignamos una IP publica al Master Node
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip
resource "azurerm_public_ip" "myPublicIp1" {
  count               = length(var.vmsB2s)
  name                = "PublicIP${var.vmsB2s[count.index]}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"

    tags = {
        environment = "CP2"
    }

}

########## Worker node and NFS node ##########

# Creamos la tarjeta de Red de los Worker nodes y el servidor NFS
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface
resource "azurerm_network_interface" "myNic2" {
  name                = "vmnic${var.vmsBD1_v2[count.index]}"
  count               = length(var.vmsBD1_v2)
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
    name                           = "myipconfiguration${var.vmsBD1_v2[count.index]}"
    subnet_id                      = azurerm_subnet.mySubnet.id 
    private_ip_address_allocation  = "Static"
    private_ip_address             = "10.0.1.${count.index + 20}"
    public_ip_address_id           = azurerm_public_ip.myPublicIp2[count.index].id
  }

    tags = {
        environment = "CP2"
    }

}

# Creamos una IP pública para los Worker nodes y el servidor NFS
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip
resource "azurerm_public_ip" "myPublicIp2" {
  count               = length(var.vmsBD1_v2)
  name                = "PublicIP${var.vmsBD1_v2[count.index]}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"

    tags = {
        environment = "CP2"
    }

}
