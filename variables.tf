variable "vault_addr" {
  type        = string
  description = "The address of the Vault server"
  sensitive   = true
}

variable "consul_http_addr" {
  type        = string
  description = "URL of the Consul server endpoint"
  sensitive   = false
  default     = "http://bare:8500"
}
