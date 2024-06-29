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
variable "consul_backend_path" {
  type        = string
  description = "Path to mount Consul Backend on"
  sensitive   = false
  default     = "hashi_at_home"
}

variable "consul_token" {
  type        = string
  sensitive   = true
  description = "Consul token used to configured consul secret backend"
}

variable "nomad_server_token_role" {
  type        = string
  description = "Name of the role to be applied to tokens issued to Nomad servers"
  sensitive   = false
  default     = "nomad-cluster"
}

variable "github_organization" {
  type        = string
  description = "Name of the github organisation used to authenticate users with the github auth method"
  default     = "hashi-at-home"
  sensitive   = false
}
