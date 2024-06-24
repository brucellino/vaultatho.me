# CA for Hashi at home
resource "vault_mount" "hah_pki" {
  path                      = "pki_hah"
  description               = "CA H@H services"
  type                      = "pki"
  default_lease_ttl_seconds = "604800"
  max_lease_ttl_seconds     = "315360000"
}

# # Root certificate for H@H
resource "vault_pki_secret_backend_root_cert" "root_cert" {
  backend              = vault_mount.hah_pki.path
  type                 = "internal"
  common_name          = "hashiatho.me"
  ttl                  = "315360000"
  format               = "pem"
  private_key_format   = "der"
  key_type             = "rsa"
  key_bits             = "4096"
  exclude_cn_from_sans = true
  # ou                   = "Vault@Home"
  # organization         = "H@H"
  # country              = "IT"
  # locality             = "Catania"
}

# H@H distribution points
resource "vault_pki_secret_backend_config_urls" "hah_urls" {
  backend = vault_mount.hah_pki.path
  issuing_certificates = [
    "${var.vault_addr}/v1/${vault_mount.hah_pki.path}/ca"
  ]
  crl_distribution_points = [
    "${var.vault_addr}/v1/${vault_mount.hah_pki.path}/crl"
  ]
}


# Intermediate certificate for H@H
resource "vault_mount" "hah_pki_int" {
  path        = "pki_hah_int"
  description = "Intermediate CA for Hashi at home services"
  type        = "pki"

  default_lease_ttl_seconds = "604800"
  max_lease_ttl_seconds     = "315360000"
}

# Intermediate cert for H@H CA
resource "vault_pki_secret_backend_intermediate_cert_request" "hah_pki_int" {
  depends_on           = [vault_mount.hah_pki]
  backend              = vault_mount.hah_pki_int.path
  type                 = "internal"
  common_name          = "hashiatho.me Intermediate Authority"
  format               = "pem"
  private_key_format   = "der"
  key_type             = "rsa"
  key_bits             = "4096"
  exclude_cn_from_sans = false
  ou                   = "Vault@Home Intermediate Authority"
  organization         = "H@H"
  country              = "IT"
  locality             = "Catania"
  # ip_sans              = ["192.168.1.14"]
}

# signed cert.
resource "vault_pki_secret_backend_root_sign_intermediate" "hah_int_sign" {
  depends_on  = [vault_pki_secret_backend_intermediate_cert_request.hah_pki_int]
  backend     = vault_mount.hah_pki.path
  csr         = vault_pki_secret_backend_intermediate_cert_request.hah_pki_int.csr
  common_name = "Vault@Home Intermediate Authority"
  ttl         = "315360000"
}

resource "vault_pki_secret_backend_intermediate_set_signed" "hah_int" {
  backend     = vault_mount.hah_pki_int.path
  certificate = vault_pki_secret_backend_root_sign_intermediate.hah_int_sign.certificate
}


# H@H Intermediate CA role
resource "vault_pki_secret_backend_role" "hah_int_role" {
  backend = vault_mount.hah_pki_int.path
  name    = "hah_int_role"
  key_usage = [
    "DigitalSignature",
    "KeyEncipherment",
    "KeyAgreement"
  ]
  allowed_domains = [
    "*.orca-ordinal.ts.net",
    "*.service.consul",
    "*.node.consul",
    "*.node.dc1.consul",
    "*.hashiatho.me"
  ]

  allow_bare_domains = true
  allow_subdomains   = true
  allow_glob_domains = true
  allow_ip_sans      = true
}

# H@H distribution points
resource "vault_pki_secret_backend_config_urls" "hah_int_urls" {
  backend = vault_mount.hah_pki_int.path
  issuing_certificates = [
    "${var.vault_addr}/v1/${vault_mount.hah_pki_int.path}/ca"
  ]
  crl_distribution_points = [
    "${var.vault_addr}/v1/${vault_mount.hah_pki_int.path}/crl"
  ]

}

resource "vault_pki_secret_backend_crl_config" "hah_int_config" {
  backend      = vault_mount.hah_pki_int.path
  expiry       = "730h"
  auto_rebuild = true
  enable_delta = true
}
