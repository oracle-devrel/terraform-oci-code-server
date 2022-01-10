# Copyright (c) 2019, 2021, Oracle Corporation and/or affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

# provider identity parameters
variable "region" {
  description = "the oci region where resources will be created"
  type        = string
  # no default value, asking user to explicitly set this variable's value. see codingconventions.adoc
  # List of regions: https://docs.cloud.oracle.com/iaas/Content/General/Concepts/regions.htm#ServiceAvailabilityAcrossRegions
}

variable "tenancy_ocid" {
  description = "tenancy ocid where to create the sources"
  type        = string
  # no default value, asking user to explicitly set this variable's value. see codingconventions.adoc
}

variable "api_fingerprint" {
  description = "fingerprint of oci api private key"
  type        = string
  default = ""
}

variable "api_private_key_path" {
  description = "path to oci api private key used"
  type        = string
  default = ""
}

variable "user_ocid" {
  description = "ocid of user that terraform will use to create the resources"
  type        = string
  default = ""
}

# general oci parameters
variable "compartment_ocid" {
  description = "compartment ocid where to create all resources"
  type        = string
  default = ""
}

variable "freeform_tags" {
  description = "simple key-value pairs to tag the resources created using freeform tags."
  type        = map(string)
  default     = {
    "terraformed" = "Please do not edit manually" ,
    "app"         = "code-server" ,
    "github"      = "https://github.com/oracle-devrel/terraform-oci-code-server",
    "oci"         = "ODE"  
  }
}

variable "defined_tags" {
  description = "predefined and scoped to a namespace to tag the resources created using defined tags."
  type        = map(string)
  default     = null
}


# compute instance parameters

variable "shape" {
  description = "The shape of an instance."
  type        = string
  default     = "VM.Standard.E4.Flex"
}

variable "instance_flex_ocpus" {
  type        = number
  description = "(Updatable) The total number of OCPUs available to the instance."
  default     = 1
}

variable "instance_flex_memory_in_gbs" {
  type        = number
  description = "(Updatable) The total amount of memory available to the instance, in gigabytes."
  default     = null
}

variable "instance_display_name" {
  description = "(Updatable) A user-friendly name for the instance. Does not have to be unique, and it's changeable."
  type        = string
  default     = "oci-code-server"
}


variable "instance_ad_number" {
  description = "The availability domain number of the instance. If none is provided, it will start with AD-1 and continue in round-robin."
  type        = number
  default     = 1
}

# operating system parameters

# if both ssh_public-keys and ssh_public_key_path are provided, ssh_public_keys takes priority
variable "ssh_public_keys" {
  description = "Public SSH key(s) provided as string value"
  type = string
  default = ""
}

variable "ssh_public_key_path" {
  description = "Public SSH key file path"
  type = string
  default = ""
}

# networking parameters

variable "public_ip" {
  description = "Whether to create a Public IP to attach to primary vnic and which lifetime. Valid values are NONE, RESERVED or EPHEMERAL."
  type        = string
  default     = "EPHEMERAL"
}

variable "vcn_cidr" {
  description = "The IPv4 CIDR block the VCN will use."
  default     = "172.16.0.0/28"
  type        = string
}


variable "subnets" {
  description = "parameters to cidrsubnet function to calculate subnet masks within the VCN."
  default = {
    vsc  = { newbits = 2, netnum = 0}
  }
  type = map(any)
}


