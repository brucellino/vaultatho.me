# Create Nomad secrets mount for all deployments
resource "vault_nomad_secret_backend" "catch_all" {
  backend                   = "nomad"
  description               = "Nomad default secrets"
  address                   = "http://nomad.service.consul:4646"
  default_lease_ttl_seconds = "3600"
  max_lease_ttl_seconds     = "86400"
}

# Create vault role for the nomad backend to issue tokens for nomad jobs
resource "vault_nomad_secret_role" "catch_all" {
  backend  = vault_nomad_secret_backend.catch_all.backend
  role     = "nomad_catch_all"
  type     = "client"
  policies = ["nomad-monitoring", "nomad-read", "nomad-tls"]
}


# Create Vault policy from nomad monitoring data
resource "vault_policy" "nomad_monitoring" {
  name   = "nomad-monitoring"
  policy = file("${path.module}/policies/nomad-monitoring.hcl")
}

# Vault policy for nomad to read kv data for deployments
resource "vault_policy" "nomad_read" {
  name   = "nomad-read"
  policy = <<EOT
  # Nomad agents can read all secrets in hashiatho.me-v2 mount
  path "${vault_mount.hashiathome-kv-v2.path}/*" {
    capabilities = ["read", "list"]
  }
  EOT
}

# Vault mTLS
# CA for Hashi at home
resource "vault_mount" "pki_hah_nomad" {
  path        = "pki_hah_nomad"
  description = "CA for Nomad at home services"
  type        = "pki"

  default_lease_ttl_seconds = "604800"
  max_lease_ttl_seconds     = "315360000"
}

# Root certificate for Nomad@Home
resource "vault_pki_secret_backend_root_cert" "pki_hah_nomad_root" {
  backend              = vault_mount.pki_hah_nomad.path
  type                 = "internal"
  common_name          = "global.nomad"
  ttl                  = "315360000"
  format               = "pem"
  private_key_format   = "der"
  key_type             = "rsa"
  key_bits             = "4096"
  exclude_cn_from_sans = true
  # ou                   = "Nomad@Home"
  # organization         = "Nomad@Home"
  # country              = "IT"
  # locality             = "Catania"
}

# Nomad CA distribution points
resource "vault_pki_secret_backend_config_urls" "pki_hah_nomad" {
  backend = vault_mount.pki_hah_nomad.path
  issuing_certificates = [
    "${var.vault_addr}/v1/${vault_mount.pki_hah_nomad.path}/ca"
  ]
  crl_distribution_points = [
    "${var.vault_addr}/v1/${vault_mount.pki_hah_nomad.path}/crl"
  ]
}


# Intermediate CA mount Nomad
resource "vault_mount" "pki_hah_nomad_int" {
  path        = "pki_hah_nomad_int"
  description = "Intermediate CA for Nomad Hashi at home services"
  type        = "pki"

  default_lease_ttl_seconds = "604800"
  max_lease_ttl_seconds     = "315360000"
}

# Intermediate cert for Nomad CA
resource "vault_pki_secret_backend_intermediate_cert_request" "pki_hah_nomad_int" {
  depends_on           = [vault_mount.pki_hah_nomad_int]
  backend              = vault_mount.pki_hah_nomad_int.path
  type                 = "internal"
  common_name          = "global.nomad Intermediate Authority"
  format               = "pem"
  private_key_format   = "der"
  key_type             = "rsa"
  key_bits             = "4096"
  exclude_cn_from_sans = false
  ou                   = "Nomad@Home Intermediate Authority"
  organization         = "nomad"
  country              = "IT"
  locality             = "Catania"
}

# signed cert.
resource "vault_pki_secret_backend_root_sign_intermediate" "pki_hah_nomad_int" {
  depends_on  = [vault_pki_secret_backend_intermediate_cert_request.pki_hah_nomad_int]
  backend     = vault_mount.pki_hah_nomad.path
  csr         = vault_pki_secret_backend_intermediate_cert_request.pki_hah_nomad_int.csr
  common_name = "global.nomad Intermediate Authority"
  ttl         = "315360000"
}

resource "vault_pki_secret_backend_intermediate_set_signed" "pki_hah_nomad_int" {
  backend     = vault_mount.pki_hah_nomad_int.path
  certificate = vault_pki_secret_backend_root_sign_intermediate.pki_hah_nomad_int.certificate
}


# H@H Nomad Intermediate CA role
resource "vault_pki_secret_backend_role" "pki_hah_nomad_int" {
  backend         = vault_mount.pki_hah_nomad_int.path
  name            = "nomad_hah_int_role"
  allowed_domains = ["global.nomad"]

  key_usage = [
    "DigitalSignature",
    "KeyEncipherment",
    "KeyAgreement"
  ]

  allow_bare_domains = true
  allow_subdomains   = true
  allow_glob_domains = true
  allow_ip_sans      = true
  require_cn         = false
  generate_lease     = true
}

# Nomad CA CRL distribution points
resource "vault_pki_secret_backend_config_urls" "nomad_int_urls" {
  backend = vault_mount.pki_hah_nomad_int.path
  issuing_certificates = [
    "${var.vault_addr}/v1/${vault_mount.hah_pki_int.path}/ca"
  ]
  crl_distribution_points = [
    "${var.vault_addr}/v1/${vault_mount.hah_pki_int.path}/crl"
  ]
}

# Vault policy for nomad agents to issue themselves TLS certificates
resource "vault_policy" "nomad_tls" {
  name   = "nomad-tls"
  policy = <<EOT
  # Nomad agents agents can request TLS certificates from the intermediate CA
  path "${vault_mount.pki_hah_nomad_int.path}/issue/nomad_hah_int_role" {
    capabilities = ["update"]
  }
  EOT
}
