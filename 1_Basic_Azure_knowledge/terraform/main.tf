provider "azurerm" {

    version = "~>2.0"
    features {}

    subscription_id = "${var.arm_subscription_id}"
    client_id = "${var.arm_client_id}"
    client_secret = "${var.arm_client_secret}"
    tenant_id = "${var.arm_tenant_id}"
    }

# Creating resource group
resource "azurerm_resource_group" "sriniRG" {
    name     = "sriniRGassigment"
    location = "${var.arm_region}"

    tags = {
        environment = "sriniassignment"
    }
}

# Creating virtual network
resource "azurerm_virtual_network" "sriniVNET" {
    name                = "sriniassigmentVNET"
    address_space       = ["192.168.0.0/16"]
    location            = "${var.arm_region}"
    resource_group_name = azurerm_resource_group.sriniRG.name

    tags = {
        environment = "sriniassignment"
    }
}

# Creating subnet
resource "azurerm_subnet" "sriniSUBNET" {
    name                 = "sriniassigmentSUBNET"
    resource_group_name  = azurerm_resource_group.sriniRG.name
    virtual_network_name = azurerm_virtual_network.sriniVNET.name
    address_prefix       = "192.168.1.0/24"
}

# Creating public IP-1
resource "azurerm_public_ip" "sriniPubIP1" {
    name                         = "sriniassignmentPubIP1"
    location                     = "${var.arm_region}"
    resource_group_name          = azurerm_resource_group.sriniRG.name
    allocation_method            = "Dynamic"

    tags = {
        environment = "sriniassignment"
    }
    
}

# Creating public IP-2
resource "azurerm_public_ip" "sriniPubIP2" {
    name                         = "sriniassignmentPubIP2"
    location                     = "${var.arm_region}"
    resource_group_name          = azurerm_resource_group.sriniRG.name
    allocation_method            = "Dynamic"

    tags = {
        environment = "sriniassignment"
    }
}


# Creating Network Security Group and rule
resource "azurerm_network_security_group" "sriniSG" {
    name                = "sriniassignmentSecurityGroup"
    location            = "${var.arm_region}"
    resource_group_name = azurerm_resource_group.sriniRG.name

    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        environment = "sriniassignment"
    }
}

# Creating network interface-1
resource "azurerm_network_interface" "sriniNIC1" {
    name                      = "sriniassignmentNIC1"
    location                  = "${var.arm_region}"
    resource_group_name       = azurerm_resource_group.sriniRG.name

    ip_configuration {
        name                          = "sriniNICConfiguration"
        subnet_id                     = azurerm_subnet.sriniSUBNET.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.sriniPubIP1.id
    }

    tags = {
        environment = "sriniassignment"
    }
}

# Creating network interface-2
resource "azurerm_network_interface" "sriniNIC2" {
    name                      = "sriniassignmentNIC2"
    location                  = "${var.arm_region}"
    resource_group_name       = azurerm_resource_group.sriniRG.name

    ip_configuration {
        name                          = "sriniNICConfiguration"
        subnet_id                     = azurerm_subnet.sriniSUBNET.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.sriniPubIP2.id
    }

    tags = {
        environment = "sriniassignment"
    }
}
# Connecting the security group to the network interface-1
resource "azurerm_network_interface_security_group_association" "association1" {
    network_interface_id      = azurerm_network_interface.sriniNIC1.id
    network_security_group_id = azurerm_network_security_group.sriniSG.id
}
# Connecting the security group to the network interface-2
resource "azurerm_network_interface_security_group_association" "association2" {
    network_interface_id      = azurerm_network_interface.sriniNIC2.id
    network_security_group_id = azurerm_network_security_group.sriniSG.id
}
# Generating random text for a unique storage account name
#resource "random_id" "randomId" {
#    keepers = {
#        resource_group = azurerm_resource_group.sriniRG.name
#    }
#
#    byte_length = 8
#}

# Creating storage account for boot diagnostics
#resource "azurerm_storage_account" "sriniSTORAGEACC1" {
#    name                        = "diag${random_id.randomId.hex}"
#    resource_group_name         = azurerm_resource_group.sriniRG.name
#    location                    = "${var.arm_region}"
#    account_tier                = "Standard"
#    account_replication_type    = "LRS"

#    tags = {
#        environment = "sriniassignment"
#    }
#}