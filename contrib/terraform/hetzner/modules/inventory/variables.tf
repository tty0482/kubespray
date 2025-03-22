variable master_ip_addresses {
  type = map(object({
    public_ip  = string
    private_ip = string
  }))
}

variable worker_ip_addresses {
  type = map(object({
    public_ip  = string
    private_ip = string
  }))
}

variable username {
}

variable network_id {
}

variable "inventory_file" {
  description = "Where to store the generated inventory file"
}
