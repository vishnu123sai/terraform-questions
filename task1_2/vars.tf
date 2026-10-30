variable "ami_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}

variable "environment" {
  default = "dev"
}

variable "owner" {
  default = "DevOps"
}

variable "instances" {
  type = map(object({
    instance_type = string
    volume_type   = string
    volume_size   = number
    key_name      = string
  }))
}