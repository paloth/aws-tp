# resource "aws_lb" "load_balancer" {
#   name               = "load-balancer"
#   internal           = false
#   load_balancer_type = "application"

#   security_groups = [
#     aws_security_group.alb_security_group.id,
#   ]

#   subnets = aws_subnet.public.*.id

#   tags = {
#     Environment = "production"
#   }
# }

# resource "aws_lb_target_group" "target_group" {
#   name     = "target-group"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = aws_vpc.vpc.id
# }

# //resource "aws_lb_target_group_attachment" "target_group_attachment" {
# //  target_group_arn = aws_lb_target_group.target_group.arn
# //  target_id        = aws_instance.webserver.id
# //  port             = 80
# //}

# resource "aws_autoscaling_attachment" "asg_attachment_bar" {
#   autoscaling_group_name = aws_cloudformation_stack.autoscaling.outputs["AsgName"]
#   alb_target_group_arn   = aws_lb_target_group.target_group.arn
# }

# resource "aws_lb_listener" "front_end" {
#   load_balancer_arn = aws_lb.load_balancer.arn
#   port              = "80"
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.target_group.arn
#   }
# }

# resource "aws_security_group" "alb_security_group" {
#   name        = "alb-security-group"
#   description = "SG for Alb"

#   ingress {
#     from_port = 80
#     protocol  = "TCP"
#     to_port   = 80

#     cidr_blocks = [
#       "0.0.0.0/0",
#     ]
#   }

#   egress {
#     from_port = 0
#     protocol  = "-1"
#     to_port   = 0

#     cidr_blocks = [
#       "0.0.0.0/0",
#     ]
#   }

#   vpc_id = aws_vpc.vpc.id
# }
