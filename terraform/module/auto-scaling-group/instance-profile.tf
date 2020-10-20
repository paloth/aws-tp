resource "aws_iam_instance_profile" "self" {
  count = var.role_name != null ? 1 : 0
  name  = "${var.name}-${var.env}"
  role  = var.role_name
}
