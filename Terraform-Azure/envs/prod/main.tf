resource "azurerm_resource_group" "rg" {

  name     = "rg-prod"
  location = var.location

}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-prod"
  location            = var.location
  address_space       = ["10.0.0.0/16"]
  resource_group_name = azurerm_resource_group.rg.name

}

resource "azurerm_subnet" "subnet" {

  name                 = "subnet-prod"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/16"]

}

module "windows_vm" {

  source              = "../../modules/windows-vm"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  vm_name             = var.vm_name
  vm_size             = var.vm_size
  admin_password      = var.admin_password
  admin_username      = var.admin_username
  subnet_id           = azurerm_subnet.subnet.id

}