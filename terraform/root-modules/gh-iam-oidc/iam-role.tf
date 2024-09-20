module "github_oidc" {

  source               = "github.com/Measurabl/terraform-github-oidc-role.git?ref=1.0.2"
  role_name            = var.gh_oidc_role_name
  oidc_subjects        = ["repo:Measurabl/${var.repo_name}:*"]
  dynamodb_tables      = ["arn:aws:dynamodb:${var.aws_region}:${data.aws_caller_identity.current.account_id}:table/${var.tf_dynamo_db}"]
  s3_buckets           = ["arn:aws:s3:::${var.tf_state_bucket}"]
  s3_bucket_objects    = ["arn:aws:s3:::${var.tf_state_bucket}/*"]
  permissions_boundary = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/${var.domain}-terragrunt-tutorial-access"
}

# Grant the IAM role additional permissons beyond Terragrunt access
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy
resource "aws_iam_role_policy" "more_perms" {

  for_each = local.iam_perms
  name     = "${each.key}-permissions"
  role     = module.github_oidc.iam_role.name
  policy   = each.value
}

locals {
  iam_perms = {
    self-manage = data.aws_iam_policy_document.gh_oidc_role_perms.json,
    s3          = data.aws_iam_policy_document.s3_perms.json,
  }
}
