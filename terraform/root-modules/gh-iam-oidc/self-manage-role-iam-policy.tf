data "aws_iam_policy_document" "gh_oidc_role_perms" {

  statement {
    sid    = "GHIAMRoleAccess"
    effect = "Allow"
    actions = [
      "iam:*Role*"
    ]
    resources = [
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.gh_oidc_role_name}",
    ]
  }
}
