variable "name" {
  description = "The broker machine's name. A live machine keeps its name."
  type        = string
}

variable "region" {
  description = "The region slug (e.g. tor1)."
  type        = string
}

variable "size" {
  description = "The machine size slug."
  type        = string
}

variable "image" {
  description = "The OS image the machine was created from. Changing it recreates the machine: adapters ignore later drift."
  type        = string
}

variable "private_network_id" {
  description = "The private network (VPC) of the machine."
  type        = string
}

variable "tags" {
  description = "Tags on the machine; the firewall applies to them."
  type        = list(string)
  default     = []
}

variable "monitoring" {
  description = "Whether the provider's metrics agent is enabled."
  type        = bool
  default     = false
}

variable "firewall" {
  description = "The firewall in front of the machine: inbound and outbound rules (ports \"all\" for every port)."
  type = object({
    name = string
    inbound = list(object({
      protocol = string
      ports    = optional(string)
      sources  = list(string)
    }))
    outbound = list(object({
      protocol     = string
      ports        = optional(string)
      destinations = list(string)
    }))
  })
  validation {
    condition = alltrue([
      for r in concat(var.firewall.inbound, var.firewall.outbound) : contains(["tcp", "udp", "icmp"], r.protocol)
    ])
    error_message = "firewall rules: protocol tcp, udp or icmp."
  }
  validation {
    condition     = alltrue([for r in var.firewall.inbound : !(contains(r.sources, "0.0.0.0/0") && r.ports == "22")])
    error_message = "firewall: SSH (22) is never open to the whole internet."
  }
}
