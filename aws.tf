# AWS Secrets backend configuration
# We only add the role here, since we don't want to add the
# secrets in this file

# resource "vault_aws_secret_backend_role" "full_access" {
#   backend         = "acg"
#   name            = "full-access"
#   credential_type = "iam_user"
#   policy_document = <<EOT
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Sid": "AllowAllPermissions",
#       "Effect": "Allow",
#       "NotAction": [
#         "lightsail:*",
#         "sagemaker:*"
#       ],
#       "Resource": "*"
#     }
#   ]
# }
# EOT
# }
