data "aws_caller_identity" "current" {}

data "aws_subnet_ids" "current" {
  vpc_id = var.vpc_id
}
