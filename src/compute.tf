/*
 * Copyright (c) 2019 Oracle Corporation Japan
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND
 */

# Compute Instance
resource "tls_private_key" "public_private_key_pair" {
  algorithm = "RSA"
}

resource "oci_core_instance" "oke-client" {
  availability_domain = data.oci_identity_availability_domains.ashburn.availability_domains[0]["name"]
  compartment_id      = var.compartment_ocid
  display_name        = "oke-client"
  shape               = var.instance_shape

  create_vnic_details {
    subnet_id        = oci_core_subnet.subnet1.id
    display_name     = "primaryvnic"
    assign_public_ip = true
  }

  source_details {
    source_type = "image"
    source_id   = var.instance_image_ocids[var.region]
  }

  extended_metadata = {
    ssh_authorized_keys = tls_private_key.public_private_key_pair.public_key_openssh
  }
}

resource "null_resource" "remote-exec" {
  depends_on = [oci_core_instance.oke-client]

  provisioner "remote-exec" {
    connection {
      agent       = false
      timeout     = "15m"
      host        = oci_core_instance.oke-client.public_ip
      user        = "opc"
      private_key = tls_private_key.public_private_key_pair.private_key_pem
    }

    inline = [
      "sudo yum install git -y",
      "sudo yum install docker-engine -y",
      "sudo /bin/systemctl start docker.service",
      "sudo usermod -aG docker opc",
      "sudo /bin/systemctl restart docker.service",
      "sudo yum -y install python3",
      "sudo pip3 install oci-cli",
      "curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl",
      "chmod +x ./kubectl",
      "sudo mv ./kubectl /usr/local/bin/kubectl",
      "kubectl version --client=true",
    ]
  }
}

output "oke-client" {
  value = [oci_core_instance.oke-client.public_ip]
}

output "private_key_pem" {
  value = [tls_private_key.public_private_key_pair.private_key_pem]
  sensitive = true
}

