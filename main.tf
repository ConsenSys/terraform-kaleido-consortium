terraform {
  required_version = ">= 0.10.3" # introduction of Local Values configuration language feature
}

resource "kaleido_consortium" "this" {
  name = "${var.name}"
  description = "${var.description}"
  mode = "${var.mode}"
}

resource "kaleido_environment" "this" {
  count = "${length(var.environments) > 0 ? length(var.environments) : 0}"
  consortium_id = "${kaleido_consortium.this.id}"
  name = "${element(var.environments, count.index)}"
  description = "${element(var.environments, count.index)}"
  env_type = "${var.env_type}"
  consensus_type = "${var.consensus_type}"
}

/*
Create ${var.number_of_nodes} nodes in each environment, must be linked to a consortium, environment, and membership.
*/
resource "kaleido_node" "this" {
  count = "${var.number_of_nodes}"
  consortium_id = "${kaleido_consortium.this.id}"
  environment_id = "${kaleido_environment.this.*.id}"
  membership_id = "${kaleido_membership.this.id}"
  name = "node-${count.index+1}"
}

/*
Create an appkey for the "kaleido_membership" resource in
every environment.
*/
resource "kaleido_app_key" "this" {
  consortium_id = "${kaleido_consortium.this.id}"
  environment_id = "${kaleido_environment.this.*.id}"
  membership_id = "${kaleido_membership.kaleido.id}"
}