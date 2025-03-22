provider "hcloud" {}

module "kubernetes" {
  source = "./modules/kubernetes-cluster"
  count = var.distro == "ubuntu" ? 1 : 0

  prefix = var.prefix

  zone = var.zone

  machines = var.machines

  ssh_public_keys = var.ssh_public_keys
  network_zone    = var.network_zone

  ssh_whitelist        = var.ssh_whitelist
  api_server_whitelist = var.api_server_whitelist
  nodeport_whitelist   = var.nodeport_whitelist
  ingress_whitelist    = var.ingress_whitelist

  inventory_file       = var.inventory_file
}

module "kubernetes_flatcar" {
  source = "./modules/kubernetes-cluster-flatcar"
  count = var.distro == "flatcar" ? 1 : 0

  prefix = var.prefix

  zone = var.zone

  machines = var.machines

  ssh_private_key_path = var.ssh_private_key_path

  ssh_public_keys = var.ssh_public_keys
  network_zone    = var.network_zone

  ssh_whitelist        = var.ssh_whitelist
  api_server_whitelist = var.api_server_whitelist
  nodeport_whitelist   = var.nodeport_whitelist
  ingress_whitelist    = var.ingress_whitelist

  inventory_file       = var.inventory_file
}
