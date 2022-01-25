variable "vsphere_user" {
  description = "User used to access vCenter - typically administrator@vsphere.local"
  type        = string
}

variable "vsphere_password" {
  description = "Password used to access vCenter"
  type        = string
}

variable "vsphere_server" {
  description = "vCenter Server Address - IP or DNS"
  type        = string
}

variable "vsphere_datacenter" {
  description = "Name of the Datacenter used in vCenter to store the VM"
  #If not set, use "Datacenter" as the default
  type    = string
  default = "Datacenter"
}

variable "vsphere_resource_pool" {
  description = "Name of the vSphere resource pool being used to allocate for the VM."
  #If no Resource Pool is being used, specify a vSphere Server Name/Resources
  type = string
}

variable "vsphere_cluster" {
  description = "Name of the vSphere Cluster used to for creating the VM"
  #If no Cluster is being used, leave blank.
  type    = string
  default = ""
}

variable "vsphere_vm_template_name" {
  description = "Name of the stored VM template to use when creating the VM"
  type        = string
}

variable "vsphere_vm_name" {
  description = "Name of the Virtual Machine being created"
  type        = string
}

variable "vsphere_network_portgroup" {
  description = "Network Portgroup to attach VM to"
  type        = string
  default     = "VM Network"
}

variable "vsphere_network_ipaddr" {
  description = "Static IP address for network"
  type        = string
}

variable "vsphere_network_cidr" {
  description = "CIDR Netmask for Subnet"
  type        = number
}

variable "vsphere_network_gw" {
  description = "IPv4 Network Gateway"
  type        = string
}

variable "vsphere_network_dns" {
  description = "List of DNS Servers"
  type        = list(string)
}

variable "vsphere_vm_hostname" {
    description = "Hostname of the new VM"
    type = string
}

variable "vsphere_vm_domain" {
    description = "Domain of the new VM"
    type = string
}

variable "vsphere_datastore" {
  description = "The vSphere datastore volume to store the new VM files on"
  type        = string
}

variable "vsphere_vm_cpucount" {
  description = "The number of vCPU to assign the new VM"
  type        = number
}

variable "vsphere_vm_memcount" {
  description = "The number of MB to assign the new VM"
  type        = number
}