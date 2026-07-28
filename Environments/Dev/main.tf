# variable "dev-RG" {}
# variable "dev-stg" {}
# variable "dev-vnets" {}
# variable "dev-subnets" {}
# variable "dev-pips" {}
# variable "dev-vms" {}


module "resource_group" {
  source = "../../Child_Modules/azurerm_resource_group"
  rgs    = var.dev-RG

}

module "storage_account" {
  depends_on = [module.resource_group]
  source     = "../../Child_Modules/azurerm_storage_account"
  stg        = var.dev-stg
}

module "virtual_network" {
  depends_on = [module.resource_group]
  source     = "../../Child_Modules/azurerm_vnet"
  vnets      = var.dev-vnets
}

module "subnets" {
  depends_on = [module.virtual_network]
  source     = "../../Child_Modules/azurerm_subnet"
  subnets    = var.dev-subnets
}

module "public_ips" {
  depends_on = [module.resource_group]
  source     = "../../Child_Modules/azurerm_public_ip"
  pips       = var.dev-pips
}

module "virtual_machines" {
  depends_on = [module.subnets, module.public_ips]
  source     = "../../Child_Modules/azurerm_virtual_machine"
  vms        = var.dev-vms
}
