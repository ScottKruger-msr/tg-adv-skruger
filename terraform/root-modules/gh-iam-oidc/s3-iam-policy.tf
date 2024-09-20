data "aws_iam_policy_document" "s3_perms" {

  statement {
    effect = "Allow"
    actions = [
      "s3:Get*",
      "s3:ListBucket",
      "s3:CreateBucket",
      "s3:DeleteBucket",
      "s3:PutBucketVersioning",
      "s3:PutEncryptionConfiguration",
      "s3:PutBucketPublicAccessBlock",
      "s3:PutBucketTagging"
    ]
    resources = [
      # TODO: Update this if you changed the bucket name in the s3 module inputs
      "arn:aws:s3:::${var.namespace}-${var.stage}-${var.domain}-udp-tutorial-${var.user_name}",
      "arn:aws:s3:::${var.namespace}-${var.stage}-${var.domain}-udp-tutorial-${var.user_name}/*"
    ]
  }

  # These actions do not support resource-level permissions
  statement {
    effect = "Allow"
    actions = [
      "s3:ListAllMyBuckets"
    ]
    resources = [
      "*"
    ]
  }
}
