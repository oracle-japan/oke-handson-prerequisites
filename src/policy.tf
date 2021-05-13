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

# Policy for OKE Service
resource "oci_identity_policy" "OKE_Policy" {
  # Required
  compartment_id = var.tenancy_ocid
  description    = var.policy_description
  name           = var.policy_name
  statements     = var.policy_statements
  # Optional
  #defined_tags = {"Operations.CostCenter"= "42"}
  #freeform_tags = {"Department"= "Finance"}
  #version_date = "${var.policy_version_date}"
}

