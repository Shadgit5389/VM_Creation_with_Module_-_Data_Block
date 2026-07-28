# data code for subnet without for_each
# data "azurerm_subnet" "frontend_subnet" {
#   name                 = "Dev-netflix-subnet"
#   virtual_network_name = "Dev-shaniVnet"
#   resource_group_name  = "Dev-shadRG1"
# }
# data "azurerm_subnet" "backend_subnet" {
#   name                 = "Dev-starbucks-subnet"
#   virtual_network_name = "Dev-shaniVnet"
#   resource_group_name  = "Dev-shadRG1"
# }

# data code for subnet with for_each
data "azurerm_subnet" "subnets" {
  for_each             = var.vms
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}

# data code for pip without for_each
# data "azurerm_public_ip" "frontend_pip" {
#   name                = "pip-frontend-vm"
#   resource_group_name = "Dev-shadRG1"
# }
# data "azurerm_public_ip" "backend_pip" {
#   name                = "pip-backend-vm"
#   resource_group_name = "Dev-shadRG1"
# }

# data code for pip with for_each
data "azurerm_public_ip" "public_ips" {
  for_each            = var.vms
  name                = each.value.pip_name
  resource_group_name = each.value.resource_group_name
}