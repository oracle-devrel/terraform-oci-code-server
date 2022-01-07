# get latest Ubuntu Linux 16.04 image
data "oci_core_images" "ubuntu-20-04" {
  compartment_id = var.compartment_ocid
  operating_system = "Canonical Ubuntu"
  filter {
    name = "display_name"
    values = ["^Canonical-Ubuntu-20.04-([\\.0-9-]+)$"]
    regex = true
  }
}

