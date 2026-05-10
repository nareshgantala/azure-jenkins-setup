resource "azurerm_linux_virtual_machine" "jenkins" {
  name                = "jenkins"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_F2"
  network_interface_ids = [
    var.nic_id,
  ]
  admin_username = "devops"
  admin_password = "Devops@12345"

  disable_password_authentication = false
  vtpm_enabled = true
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_id = "/subscriptions/9be9bd1a-817e-486f-9b33-1b1f79ed3727/resourceGroups/denmark-east/providers/Microsoft.Compute/galleries/roboshopGallery/images/roboshopImage"
  provisioner "file" {
    source      = "./install.sh"
    destination = "/home/devops/install.sh"

    connection {
        type     = "ssh"
        user     = "devops"
        password = "Devops@12345"
        host     = azurerm_linux_virtual_machine.workstation.public_ip_address
    }
    }
}

resource "null_resource" "name" {
    depends_on = [ azurerm_linux_virtual_machine.jenkins ]

    provisioner "remote-exec" {
          connection {
        type     = "ssh"
        user     = "devops"
        password = "Devops@12345"
        host     = azurerm_linux_virtual_machine.jenkins.public_ip_address
    }
    inline = [
      "chmod +x /home/devops/install.sh",
      "bash /home/devops/install.sh",
    ]

   }
}