# CA for Hashi at home
resource "vault_mount" "hah_pki" {
  path        = "PKI/hashiatho.me"
  description = "CA for Hashi at home services"
  type        = "pki"

  default_lease_ttl_seconds = "604800"
  max_lease_ttl_seconds     = "315360000"
}

# Root certificate for H@H
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
  ou                   = "Vault@Home"
  organization         = "H@H"
  country              = "IT"
  locality             = "Catania"
}

# H@H distribution points
resource "vault_pki_secret_backend_config_urls" "hah_urls" {
  backend = vault_mount.hah_pki.path
  issuing_certificates = [
    "${var.vault_addr}/v1/PKI/hashiatho.me/ca"
  ]
  crl_distribution_points = [
    "${var.vault_addr}/v1/PKI/hashiatho.me/crl"
  ]
}
