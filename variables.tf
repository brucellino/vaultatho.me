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

variable "nomad_server_token_role" {
  type        = string
  description = "Name of the role to be applied to tokens issued to Nomad servers"
  sensitive   = false
  default     = "nomad-cluster"
}
