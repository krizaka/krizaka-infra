variable "name" {
  description = "The cluster's name. A live cluster keeps its name: renaming recreates it."
  type        = string
}

variable "engine" {
  description = "The engine: pg, mysql, valkey, mongodb, kafka or opensearch."
  type        = string
  validation {
    condition     = contains(["pg", "mysql", "valkey", "mongodb", "kafka", "opensearch"], var.engine)
    error_message = "engine: pg, mysql, valkey, mongodb, kafka or opensearch."
  }
}

variable "engine_version" {
  description = "The engine's major version (e.g. \"18\")."
  type        = string
}

variable "size" {
  description = "The node size slug (e.g. db-s-1vcpu-1gb)."
  type        = string
}

variable "region" {
  description = "The region slug (e.g. tor1)."
  type        = string
}

variable "node_count" {
  description = "How many nodes (1 = no standby)."
  type        = number
  default     = 1
  validation {
    condition     = var.node_count >= 1 && var.node_count <= 3
    error_message = "node_count: 1 to 3."
  }
}

variable "private_network_id" {
  description = "The private network (VPC) the cluster lives in, or null for the region's default."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags on the cluster."
  type        = list(string)
  default     = []
}

variable "databases" {
  description = "The databases this stack keeps on the cluster. Users, roles and passwords stay with the products' migrations."
  type        = list(string)
  default     = []
  validation {
    condition     = alltrue([for d in var.databases : can(regex("^[a-z_][a-z0-9_]{0,62}$", d))])
    error_message = "databases: lowercase identifiers (letters, digits, underscores)."
  }
}

variable "maintenance_window" {
  description = "The weekly maintenance window, or null for the provider's default."
  type = object({
    day  = string
    hour = string
  })
  default = null
}
