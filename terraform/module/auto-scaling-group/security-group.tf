resource "aws_security_group" "self" {
  name        = "${var.name}-${var.env}-sg"
  description = "${var.name}-${var.env}"
  vpc_id      = var.vpc_id
  tags        = var.tags

  dynamic "ingress" {
    for_each = [
      for ingress in var.sg_ingress : {
        from_port   = ingress.from_port
        to_port     = ingress.to_port
        protocol    = ingress.protocol
        cidr_block  = ingress.cidr_block
        description = ingress.description
      }
    ]

    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = [ingress.value.cidr_block]
      description = ingress.value.description
    }
  }

  dynamic "egress" {
    for_each = [for egress in var.sg_egress : {
      from_port   = egress.from_port
      to_port     = egress.to_port
      protocol    = egress.protocol
      cidr_block  = egress.cidr_block
      description = egress.description
    }]

    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = [egress.value.cidr_block]
      description = egress.value.description
    }
  }
}
