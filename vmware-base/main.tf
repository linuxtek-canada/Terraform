#The variables are all defined in the variable.tf file.  
#The values assigned to the variables are all set in the terraform.tfvars file.

provider "vsphere" {
  #https://www.terraform.io/docs/providers/vsphere/index.html
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  #https://www.terraform.io/docs/providers/vsphere/d/datacenter.html
  name = var.vsphere_datacenter  
}

data "vsphere_datastore" "datastore" {
  #https://www.terraform.io/docs/providers/vsphere/d/datastore.html
  name          = var.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.dc.id 
}

data "vsphere_resource_pool" "pool" {
  name          = var.vsphere_resource_pool 
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  #https://www.terraform.io/docs/providers/vsphere/d/network.html
  name          = var.vsphere_network_portgroup
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  #https://www.terraform.io/docs/providers/vsphere/d/virtual_machine.html
  name          = var.vsphere_vm_template_name
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "vm" {
  name             = var.vsphere_vm_name
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = var.vsphere_vm_cpucount
  memory   = var.vsphere_vm_memcount
  guest_id = data.vsphere_virtual_machine.template.guest_id
  
  wait_for_guest_net_timeout = -1

  network_interface {
    network_id = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

   disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.template.disks.0.size
    eagerly_scrub    = data.vsphere_virtual_machine.template.disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }

  clone {
     template_uuid = data.vsphere_virtual_machine.template.id
  
    customize {      
      linux_options {
        host_name = var.vsphere_vm_hostname
        domain    = var.vsphere_vm_domain
      }

   network_interface {
        ipv4_address = var.vsphere_network_ipaddr
        ipv4_netmask = var.vsphere_network_cidr       
    }
      ipv4_gateway = var.vsphere_network_gw
      dns_server_list = var.vsphere_network_dns
    }
  }  
}