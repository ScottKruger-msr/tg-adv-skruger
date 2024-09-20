module "s3" {

  source           = "github.com/Measurabl/terraform-private-s3-bucket.git?ref=1.0.2"
  stage            = var.stage
  aws_region       = var.aws_region
  domain           = var.domain
  aws_region_short = var.aws_region_short
  bucket_name      = "${var.bucket_name}-${var.user_name}"
}
