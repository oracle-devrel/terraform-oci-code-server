# Copyright (c) 2019, 2021, Oracle Corporation and/or affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

locals {
  compartment_id = var.compartment_ocid == "" ? var.tenancy_ocid : var.compartment_ocid
  ad_number      = var.instance_ad_name == "" ? var.instance_ad_number : local.ad_map[var.instance_ad_name]
}

module "vsc_instance" {
  source = "oracle-terraform-modules/compute-instance/oci"
  # general oci parameters
  compartment_ocid            = local.compartment_id
  freeform_tags               = var.freeform_tags
  defined_tags                = var.defined_tags
  # compute instance parameters
  ad_number                   = local.ad_number
  instance_count              = 1
  instance_display_name       = var.instance_display_name
  instance_state              = "RUNNING"
  shape                       = var.use_always_free ? local.always_free_shape : var.shape
  source_ocid                 = data.oci_core_images.ubuntu-20-04.images.0.id
  source_type                 = "image"
  instance_flex_memory_in_gbs = var.use_always_free ? null : var.instance_flex_memory_in_gbs
  instance_flex_ocpus         = var.use_always_free ? 1 : var.instance_flex_ocpus
  # operating system parameters
  ssh_public_keys             = var.ssh_public_keys != "" ? var.ssh_public_keys : var.ssh_public_key_path != "" ? file(var.ssh_public_key_path) : ""
  user_data                   = base64encode(data.template_file.cloud-config.rendered)
  # networking parameters
  public_ip                   = var.public_ip
  subnet_ocids                = [oci_core_subnet.sub.id]
  primary_vnic_nsg_ids        = [oci_core_network_security_group.nsg.id]

  # storage parameters
  boot_volume_backup_policy   = "disabled"
  block_storage_sizes_in_gbs  = [50]
}


module "vcn" {
  source = "oracle-terraform-modules/vcn/oci"

  # general oci parameters
  compartment_id            = local.compartment_id
  vcn_name                  = "vsc-network"

  # vcn parameters
  lockdown_default_seclist = false
  vcn_cidrs                = [var.vcn_cidr]
  create_internet_gateway  = true

}

resource "oci_core_network_security_group" "nsg" {
  #Required
  compartment_id = local.compartment_id
  vcn_id         = module.vcn.vcn_id

  #Optional
  display_name  = "vsc-nsg"
  freeform_tags = var.freeform_tags
}

resource "oci_core_subnet" "sub" {
  #Required
  cidr_block                  = cidrsubnet(var.vcn_cidr, lookup(var.subnets["vsc"], "newbits"), lookup(var.subnets["vsc"], "netnum"))
  compartment_id              = local.compartment_id
  vcn_id                      = module.vcn.vcn_id

  #Optional
  display_name               = "vsc-sub"
  dns_label                  = "vscsub"
  prohibit_public_ip_on_vnic = false
  route_table_id             = module.vcn.ig_route_id
  freeform_tags              = var.freeform_tags
}


module "oci_security_policies" {
  source = "github.com/oracle-terraform-modules/terraform-oci-tdf-network-security"

  default_compartment_id = local.compartment_id
  default_freeform_tags  = var.freeform_tags
  vcn_id                 = module.vcn.vcn_id

  standalone_nsg_rules = {
    ingress_rules = [
      {
        nsg_id      = oci_core_network_security_group.nsg.id
        description = "code-server"
        stateless   = false
        protocol    = "6"
        src         = "0.0.0.0/0"
        src_type    = "CIDR_BLOCK"
        src_port    = null
        dst_port = {
          min = "80"
          max = "80"
        }
        icmp_code   = null
        icmp_type   = null
      }
    ]
    egress_rules = []
  }
}


