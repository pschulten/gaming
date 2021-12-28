variable "additional_tags" {
  default     = {}
  description = "Additional resource tags"
  type        = map(string)
}

variable "instance_name" {
  default     = "gaming"
  description = "The name of the EC2 Spot Instance"
  type        = string
}

variable "instance_type" {
# TODO wait for eu-west-1 default     = "g5.2xlarge"
#  default     = "g4dn.xlarge"
  default     = "g5.xlarge"
  description = "The instance type"
  type        = string
}

variable "root_block_device_size_gb" {
  default     = 512
  description = "The root EBS volume size"
  type        = number
}

