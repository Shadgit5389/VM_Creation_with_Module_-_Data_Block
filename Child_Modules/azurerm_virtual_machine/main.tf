resource "azurerm_network_interface" "shani_nic" {
  for_each            = var.vms
  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name = "internal"

    # Hardcoding subnet_id and public_ip_address_id 
    # subnet_id = "/subscriptions/b5040829-6fb6-4806-92be-0a7f26fd8012/resourceGroups/Dev-shadRG1/providers/Microsoft.Network/virtualNetworks/Dev-shaniVnet/subnets/Dev-netflix-subnet"
    # public_ip_address_id = "/subscriptions/b5040829-6fb6-4806-92be-0a7f26fd8012/resourceGroups/Dev-shadRG1/providers/Microsoft.Network/publicIPAddresses/pip-frontend-vm"

    #calling values of subnet_id and public_ip_address_id from terraform.tfvars by using for_each loop, yaha bhi both ids ki values ko terraform.tfvars me hardcode krna pad rha h. isliye ham is problem ko solve krne k liye data block ka use krke portal se dono ids ki values ko call krenge.
    # subnet_id                     = each.value.subnet_id
    # public_ip_address_id          = each.value.pip_id

    # Using data block without for_each to call the subnet_id and public_ip_address_id. jab data block use krte h to terraform.tfvars me in ids ke argumnets with value use ya hardcode nhi krne pdte. 
    # subnet_id            = data.azurerm_subnet.frontend_subnet.id
    # public_ip_address_id = data.azurerm_public_ip.frontend_pip.id

    # Using data block with for_each to call the subnet_id and public_ip_address_id. jab data block use krte h to terraform.tfvars me in ids ke argumnets with value use ya hardcode nhi krne pdte. 
    subnet_id            = data.azurerm_subnet.subnets[each.key].id
    public_ip_address_id = data.azurerm_public_ip.public_ips[each.key].id


    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "shani_vms" {
  for_each                        = var.vms
  name                            = each.value.vm_name
  resource_group_name             = each.value.resource_group_name
  location                        = each.value.location
  size                            = each.value.vm_size
  admin_username                  = each.value.admin_username
  admin_password                  = each.value.admin_password
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.shani_nic[each.key].id,
  ]


  os_disk {
    caching              = each.value.disk_caching
    storage_account_type = each.value.disk_storage_account_type
  }

  source_image_reference {
    publisher = each.value.image_publisher
    offer     = each.value.image_offer
    sku       = each.value.image_sku
    version   = each.value.image_version
  }
}
