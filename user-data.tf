# Copyright (c) 2019, 2021, Oracle Corporation and/or affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

data "template_file" "cloud-config" {
  template = <<YAML
#cloud-config
runcmd:
 - iptables -I INPUT 6 -m state --state NEW -p tcp --dport 80 -j ACCEPT
 - netfilter-persistent save
 - while fuser /var/lib/dpkg/lock >/dev/null 2>&1 ; do sleep 50; done;
 - wget https://raw.githubusercontent.com/coder/deploy-code-server/main/deploy-vm/launch-code-server.sh -O - | sh
YAML
}