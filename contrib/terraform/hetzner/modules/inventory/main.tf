locals {
  inventory = templatefile(
    "${path.module}/inventory.tpl",
    {
      connection_strings_master = join("\n", formatlist("%s ansible_user=%s ansible_host=%s ip=%s etcd_member_name=etcd%d",
        keys(var.master_ip_addresses),
        var.username,
        values(var.master_ip_addresses).*.public_ip,
        values(var.master_ip_addresses).*.private_ip,
      range(1, length(var.master_ip_addresses) + 1)))
      connection_strings_worker = join("\n", formatlist("%s ansible_user=%s ansible_host=%s ip=%s",
        keys(var.worker_ip_addresses),
        var.username,
        values(var.worker_ip_addresses).*.public_ip,
        values(var.worker_ip_addresses).*.private_ip))
      list_master = join("\n", keys(var.master_ip_addresses))
      list_worker = join("\n", keys(var.worker_ip_addresses))
      network_id  = var.network_id
    }
  )
}

resource "null_resource" "inventories" {
  provisioner "local-exec" {
    command = "echo '${local.inventory}' > ${path.cwd}/${var.inventory_file}"
  }

  triggers = {
    template = local.inventory
  }
}

