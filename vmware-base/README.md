## Terraform script to build vSphere virtual machine and configure built Packer template

This project is designed to define and build a virtual machine on VMware vSphere using Terraform.  The OS is based on a pre-built template built using Packer.  
Sample Packer scripts to use to build the template are available [here](https://github.com/linuxtek-canada/packer)

## Preparation

1.  Prepare a VM template with the installed OS, to be able to clone during the Terraform creation process.  In my case, I am using the Debian 11 Bullseye template I created with Packer using this [Debian 11 Bullseye](https://github.com/linuxtek-canada/packer/tree/master/Debian-11-Bullseye) Packer script.

Note:  Debian 10 and 11 were not added to the Guest OS Customization List until vSphere 7.0U3.  If you are building on an older version of vSphere, see [VMware KB85845](https://kb.vmware.com/s/article/85845) for explanation and manual workaround.  For more details see [this](https://communities.vmware.com/t5/VMware-vSphere-Discussions/Debian-10-guest-customizaion/m-p/528551#M10170) community thread.

Workaround Steps:

* Convert the template to VM
* Edit settings > VM Options
* Change Guest OS type to "Other Linux 64-bit"
* Convert back to template.

2.  Clone the Terraform repo, and rename the terraform-vars.sanitized file to terraform.tfvars.

3.  Fill in the details in terraform.tfvars for your vSphere environment.  This should be the only file that needs editing.

## Execution

While in the vmware-base folder, run the following to build the VM using Terraform:

```bash
terraform init
terraform plan
terraform apply
```