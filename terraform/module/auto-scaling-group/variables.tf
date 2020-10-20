# Global variable

variable "env" {
  type        = string
  description = "Infrastructure environment"
}

## Asg variable

variable "name" {
  type        = string
  description = "AutoScaling Group name"
}

variable "lt_version" {
  type        = string
  description = "Launch Template version to use"
  default     = "$Latest"
}

variable "scheduled_actions" {
  type        = map(string)
  description = "Scheduled actions for the Asg"
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Asg tags"
  default     = {}
}

variable "role_name" {
  type        = bool
  description = "Role to link to the instance profile (Must be created outside this module)"
  default     = false
}

variable "asg_capacity_max" {
  type        = number
  description = "ASG max capacity"
  default     = 1
}

variable "asg_capacity_min" {
  type        = number
  description = "ASG min capacity"
  default     = 1
}

variable "asg_capacity_desired" {
  type        = number
  description = "ASG desired capacity"
  default     = 1
}

variable "health_check_grace_period" {
  type        = number
  description = "Time (in seconds) after instance comes into service before checking health"
  default     = 300
}

variable "health_check_type" {
  type        = string
  description = "Controls how health checking is done"
  default     = "EC2"
}

variable "force_delete" {
  type        = bool
  description = "Allows deleting the autoscaling group without waiting for all instances in the pool to terminate."
  default     = false
}

variable "target_group_arns" {
  type        = list(string)
  description = "A set of aws_alb_target_group ARNs, for use with Application or Network Load Balancing."
  default     = []
}

variable "sg_ingress" {
  type = list(
    object(
      {
        from_port   = number
        to_port     = number
        protocol    = string
        cidr_block  = list(string)
        description = string
      }
    )
  )
  description = "Security group rules for the Asg"
}

## LT variables

variable "shutdown_behavior" {
  type        = string
  description = "AutoScaling instance shutdown behavior"
  default     = "stop"
}

variable "user_data" {
  type        = any
  description = "User data to execute at instance start"
  default     = null
}
