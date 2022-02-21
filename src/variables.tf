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

variable "tenancy_ocid" {
}

variable "compartment_ocid" {
}

variable "region" {
}

variable "instance_image_ocids" {
  type = map(string)
  default = {
    us-ashburn-1   = "ocid1.image.oc1.iad.aaaaaaaaoi4aun3xgz7cwwzrwkiunk6dpi7htuicu7aktsgulbnjdzb6l6aq"
    ap-tokyo-1     = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaahzjia7mnvnoufz3fk3zt4mbfumixf5w7intekiazav6bu3zn6x7q"
    ap-seoul-1     = "ocid1.image.oc1.ap-seoul-1.aaaaaaaa462u6ptrhf55j22ulq5h5u3jaeph435rm37n7kosjoblbaer3r4a"
    ca-toronto-1   = "ocid1.image.oc1.ca-toronto-1.aaaaaaaaxwee4kyxou7dol2xrtp2smfcdmhqge23b4uhqi6llhnqjf5ojxrq"
    eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaa7heh3um5n35rrnunaiiijbtccoumkio4sjfuxqzuv5zbp56sej6q"
    uk-london-1    = "ocid1.image.oc1.uk-london-1.aaaaaaaaxdpy4ydhk6scrcq3fsueyp3zxfgtn6rcyw22ziddhyiwb3l43oja"
    us-phoenix-1   = "ocid1.image.oc1.phx.aaaaaaaayvtrc3bfgi2xnzswqfws3syrnte7s37m3s6wdy62ynmk4bhmx5ca"
  }
}

provider "oci" {
  version      = ">= 3.0.0"
  tenancy_ocid = var.tenancy_ocid
  region       = var.region
}

data "oci_identity_availability_domains" "ashburn" {
  compartment_id = var.tenancy_ocid
}

### Network Variables ###

variable "vcn_cidr_block" {
  default = "10.0.0.0/16"
}

variable "dns_label_vcn" {
  default = "dnsvcn"
}

variable "subnet_cidr_w1" {
  default = "10.0.10.0/24"
}

variable "subnet_cidr_w2" {
  default = "10.0.20.0/24"
}

