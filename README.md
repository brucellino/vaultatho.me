# vaultatho.me

[![pre-commit.ci status](https://results.pre-commit.ci/badge/github/brucellino/vaultatho.me/main.svg)](https://results.pre-commit.ci/latest/github/brucellino/vaultatho.me/main)[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-%23FE5196?logo=conventionalcommits&logoColor=white)](https://conventionalcommits.org)[![Release](https://github.com/brucellino/vaultatho.me/actions/workflows/main.yml/badge.svg)](https://github.com/brucellino/vaultatho.me/actions/workflows/main.yml)


Terraform for Vault component of [Hashi@home](https://hashiatho.me)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_vault"></a> [vault](#requirement\_vault) | 5.6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_vault"></a> [vault](#provider\_vault) | 5.6.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [vault_approle_auth_backend_role.catch_all](https://registry.terraform.io/providers/hashicorp/vault/5.6.0/docs/resources/approle_auth_backend_role) | resource |
| [vault_approle_auth_backend_role.consul](https://registry.terraform.io/providers/hashicorp/vault/5.6.0/docs/resources/approle_auth_backend_role) | resource |
| [vault_approle_auth_backend_role.nomad_server](https://registry.terraform.io/providers/hashicorp/vault/5.6.0/docs/resources/approle_auth_backend_role) | resource |
| [vault_auth_backend.auto_auth_approle](https://registry.terraform.io/providers/hashicorp/vault/5.6.0/docs/resources/auth_backend) | resource |
| [vault_auth_backend.gh_approle](https://registry.terraform.io/providers/hashicorp/vault/5.6.0/docs/resources/auth_backend) | resource |
| [vault_consul_secret_backend.consul](https://registry.terraform.io/providers/hashicorp/vault/5.6.0/docs/resources/consul_secret_backend) | resource |
| [vault_consul_secret_backend_role.cluster](https://registry.terraform.io/providers/hashicorp/vault/5.6.0/docs/resources/consul_secret_backend_role) | resource |
| [vault_github_auth_backend.hah](https://registry.terraform.io/providers/hashicorp/vault/5.6.0/docs/resources/github_auth_backend) | resource |
| [vault_jwt_auth_backend.nomad](https://registry.terraform.io/providers/hashicorp/vault/5.6.0/docs/resources/jwt_auth_backend) | resource |
| [vault_jwt_auth_backend_role.nomad_jobs](https://registry.terraform.io/providers/hashicorp/vault/5.6.0/docs/resources/jwt_auth_backend_role) | resource |
| [vault_mount.hah_pki](https://registry.terraform.io/providers/hashicorp/vault/5.6.0/docs/resources/mount) | resource |
| [vault_mount.hah_pki_int](https://registry.terraform.io/providers/hashicorp/vault/5.6.0/docs/resources/mount) | resource |
| [vault_mount.hashiathome-kv-v2](https://registry.terraform.io/providers/hashicorp/vault/5.6.0/docs/resources/mount) | resource |
| [vault_mount.pki_hah_nomad](https://registry.terraform.io/providers/hashicorp/vault/5.6.0/docs/resources/mount) | resource |
| [vault_mount.pki_hah_nomad_int](https://registry.terraform.io/providers/hashicorp/vault/5.6.0/docs/resources/mount) | resource |
| [vault_nomad_secret_backend.catch_all](https://registry.terraform.io/providers/hashicorp/vault/5.6.0/docs/resources/nomad_secret_backend) | resource |
| [vault_nomad_secret_role.catch_all](https://registry.terraform.io/providers/hashicorp/vault/5.6.0/docs/resources/nomad_secret_role) | resource |
| [vault_nomad_secret_role.mgmt](https://registry.terraform.io/providers/hashicorp/vault/5.6.0/docs/resources/nomad_secret_role) | resource |
| [vault_pki_secret_backend_config_urls.hah_int_urls](https://registry.terraform.io/providers/hashicorp/vault/5.6.0/docs/resources/pki_secret_backend_config_urls) | resource |
| [vault_pki_secret_backend_config_urls.hah_urls](https://registry.terraform.io/providers/hashicorp/vault/5.6.0/docs/resources/pki_secret_backend_config_urls) | resource |
| [vault_pki_secret_backend_config_urls.nomad_int_urls](https://registry.terraform.io/providers/hashicorp/vault/5.6.0/docs/resources/pki_secret_backend_config_urls) | resource |
| [vault_pki_secret_backend_config_urls.pki_hah_nomad](https://registry.terraform.io/providers/hashicorp/vault/5.6.0/docs/resources/pki_secret_backend_config_urls) | resource |
| [vault_pki_secret_backend_crl_config.hah_int_config](https://registry.terraform.io/providers/hashicorp/vault/5.6.0/docs/resources/pki_secret_backend_crl_config) | resource |
| [vault_pki_secret_backend_intermediate_cert_request.hah_pki_int](https://registry.terraform.io/providers/hashicorp/vault/5.6.0/docs/resources/pki_secret_backend_intermediate_cert_request) | resource |
| [vault_pki_secret_backend_intermediate_cert_request.pki_hah_nomad_int](https://registry.terraform.io/providers/hashicorp/vault/5.6.0/docs/resources/pki_secret_backend_intermediate_cert_request) | resource |
| [vault_pki_secret_backend_intermediate_set_signed.hah_int](https://registry.terraform.io/providers/hashicorp/vault/5.6.0/docs/resources/pki_secret_backend_intermediate_set_signed) | resource |
| [vault_pki_secret_backend_intermediate_set_signed.pki_hah_nomad_int](https://registry.terraform.io/providers/hashicorp/vault/5.6.0/docs/resources/pki_secret_backend_intermediate_set_signed) | resource |
| [vault_pki_secret_backend_role.hah_int_role](https://registry.terraform.io/providers/hashicorp/vault/5.6.0/docs/resources/pki_secret_backend_role) | resource |
| [vault_pki_secret_backend_role.pki_hah_nomad_int](https://registry.terraform.io/providers/hashicorp/vault/5.6.0/docs/resources/pki_secret_backend_role) | resource |
| [vault_pki_secret_backend_root_cert.pki_hah_nomad_root](https://registry.terraform.io/providers/hashicorp/vault/5.6.0/docs/resources/pki_secret_backend_root_cert) | resource |
| [vault_pki_secret_backend_root_cert.root_cert](https://registry.terraform.io/providers/hashicorp/vault/5.6.0/docs/resources/pki_secret_backend_root_cert) | resource |
| [vault_pki_secret_backend_root_sign_intermediate.hah_int_sign](https://registry.terraform.io/providers/hashicorp/vault/5.6.0/docs/resources/pki_secret_backend_root_sign_intermediate) | resource |
| [vault_pki_secret_backend_root_sign_intermediate.pki_hah_nomad_int](https://registry.terraform.io/providers/hashicorp/vault/5.6.0/docs/resources/pki_secret_backend_root_sign_intermediate) | resource |
| [vault_policy.admin](https://registry.terraform.io/providers/hashicorp/vault/5.6.0/docs/resources/policy) | resource |
| [vault_policy.aws](https://registry.terraform.io/providers/hashicorp/vault/5.6.0/docs/resources/policy) | resource |
| [vault_policy.consul](https://registry.terraform.io/providers/hashicorp/vault/5.6.0/docs/resources/policy) | resource |
| [vault_policy.nomad_monitoring](https://registry.terraform.io/providers/hashicorp/vault/5.6.0/docs/resources/policy) | resource |
| [vault_policy.nomad_read](https://registry.terraform.io/providers/hashicorp/vault/5.6.0/docs/resources/policy) | resource |
| [vault_policy.nomad_server](https://registry.terraform.io/providers/hashicorp/vault/5.6.0/docs/resources/policy) | resource |
| [vault_policy.nomad_tls](https://registry.terraform.io/providers/hashicorp/vault/5.6.0/docs/resources/policy) | resource |
| [vault_policy.nomad_workloads](https://registry.terraform.io/providers/hashicorp/vault/5.6.0/docs/resources/policy) | resource |
| [vault_policy.read_only](https://registry.terraform.io/providers/hashicorp/vault/5.6.0/docs/resources/policy) | resource |
| [vault_raft_autopilot.this](https://registry.terraform.io/providers/hashicorp/vault/5.6.0/docs/resources/raft_autopilot) | resource |
| [vault_token_auth_backend_role.nomad_cluster](https://registry.terraform.io/providers/hashicorp/vault/5.6.0/docs/resources/token_auth_backend_role) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_consul_backend_path"></a> [consul\_backend\_path](#input\_consul\_backend\_path) | Path to mount Consul Backend on | `string` | `"hashi_at_home"` | no |
| <a name="input_consul_http_addr"></a> [consul\_http\_addr](#input\_consul\_http\_addr) | URL of the Consul server endpoint | `string` | `"http://bare:8500"` | no |
| <a name="input_consul_token"></a> [consul\_token](#input\_consul\_token) | Consul token used to configured consul secret backend | `string` | n/a | yes |
| <a name="input_github_organization"></a> [github\_organization](#input\_github\_organization) | Name of the github organisation used to authenticate users with the github auth method | `string` | `"hashi-at-home"` | no |
| <a name="input_nomad_mgmt_token"></a> [nomad\_mgmt\_token](#input\_nomad\_mgmt\_token) | Nomad bootstrap token | `string` | n/a | yes |
| <a name="input_nomad_server_token_role"></a> [nomad\_server\_token\_role](#input\_nomad\_server\_token\_role) | Name of the role to be applied to tokens issued to Nomad servers | `string` | `"nomad-cluster"` | no |
| <a name="input_vault_addr"></a> [vault\_addr](#input\_vault\_addr) | The address of the Vault server | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
