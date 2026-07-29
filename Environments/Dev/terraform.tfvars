dev-RG = {
  rg1 = {
    name       = "Dev-shadRG1"
    location   = "eastus"
    managed_by = "terraform"
  }
  rg2 = {
    name       = "Dev-shadRG2"
    location   = "westus"
    managed_by = "terraform"
  }
}

dev-stg = {
  stg1 = {
    stg_name                 = "devshadstg"
    resource_group_name      = "Dev-shadRG1"
    location                 = "eastus"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    container_name           = "tfstate"
    container_access_type    = "private"
  }
}

dev-vnets = {
  vnet1 = {
    name                = "Dev-shaniVnet"
    location            = "eastus"
    resource_group_name = "Dev-shadRG1"
    address_space       = ["10.0.0.0/16"]
  }
}

dev-subnets = {
  subnet1 = {
    name                 = "Dev-netflix-subnet"
    resource_group_name  = "Dev-shadRG1"
    virtual_network_name = "Dev-shaniVnet"
    address_prefixes     = ["10.0.1.0/24"]
  }
  subnet2 = {
    name                 = "Dev-starbucks-subnet"
    resource_group_name  = "Dev-shadRG1"
    virtual_network_name = "Dev-shaniVnet"
    address_prefixes     = ["10.0.2.0/24"]
  }
  subnet3 = {
    name                 = "Dev-database-subnet"
    resource_group_name  = "Dev-shadRG1"
    virtual_network_name = "Dev-shaniVnet"
    address_prefixes     = ["10.0.3.0/24"]
  }
}

dev-pips = {
  pip1 = {
    name                = "pip-frontend-vm"
    resource_group_name = "Dev-shadRG1"
    location            = "eastus"
    allocation_method   = "Static"
  }
  pip2 = {
    name                = "pip-backend-vm"
    resource_group_name = "Dev-shadRG1"
    location            = "eastus"
    allocation_method   = "Static"
  }
}

dev-vms = {
  vm1 = {
    nic_name                  = "nic-frontend-vm"
    location                  = "eastus"
    resource_group_name       = "Dev-shadRG1"
    subnet_name               = "Dev-netflix-subnet"
    virtual_network_name      = "Dev-shaniVnet"
    pip_name                  = "pip-frontend-vm"
    vm_name                   = "netflix-vm"
    vm_size                   = "Standard_DC1ds_v3"
    admin_username            = "shadadmin"
    admin_password            = "shad@123"
    disk_caching              = "ReadWrite"
    disk_storage_account_type = "Standard_LRS"
    image_publisher           = "Canonical"
    image_offer               = "ubuntu-24_04-lts"
    image_sku                 = "server"
    image_version             = "latest"

    # NOw, no need to hardcode below ids, because we are using data block
    # subnet_id = "/subscriptions/b5040829-6fb6-4806-92be-0a7f26fd8012/resourceGroups/Dev-shadRG1/providers/Microsoft.Network/virtualNetworks/Dev-shaniVnet/subnets/Dev-netflix-subnet"
    # pip_id = "/subscriptions/b5040829-6fb6-4806-92be-0a7f26fd8012/resourceGroups/Dev-shadRG1/providers/Microsoft.Network/publicIPAddresses/pip-frontend-vm"
  }
  vm2 = {
    nic_name                  = "nic-backend-vm"
    location                  = "eastus"
    resource_group_name       = "Dev-shadRG1"
    subnet_name               = "Dev-starbucks-subnet"
    virtual_network_name      = "Dev-shaniVnet"
    pip_name                  = "pip-backend-vm"
    vm_name                   = "starbucks-vm"
    vm_size                   = "Standard_DC1ds_v3"
    admin_username            = "shadadmin"
    admin_password            = "shad@123"
    disk_caching              = "ReadWrite"
    disk_storage_account_type = "Standard_LRS"
    image_publisher           = "Canonical"
    image_offer               = "ubuntu-24_04-lts"
    image_sku                 = "server"
    image_version             = "latest"

    # NOw, no need to hardcode below ids, because we are using data block
    #   subnet_id = "/subscriptions/b5040829-6fb6-4806-92be-0a7f26fd8012/resourceGroups/Dev-shadRG1/providers/Microsoft.Network/virtualNetworks/Dev-shaniVnet/subnets/Dev-starbucks-subnet"
    #   pip_id = "/subscriptions/b5040829-6fb6-4806-92be-0a7f26fd8012/resourceGroups/Dev-shadRG1/providers/Microsoft.Network/publicIPAddresses/pip-backend-vm"
  }
}
