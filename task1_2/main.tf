provider "aws" {
  region = "ap-south-1"
}

terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"
    key            = "ec2/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}

locals {
  instances = {
    for name, config in var.instances : name => config
    if name != "prod-database"
  }
}

resource "aws_instance" "regular" {
  for_each = local.instances

  ami                    = var.ami_id
  instance_type          = each.value.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids
  key_name               = each.value.key_name

  root_block_device {
    volume_type = each.value.volume_type
    volume_size = each.value.volume_size
    encrypted   = true

    iops = contains(["io1", "io2"], each.value.volume_type) ? 3000 : null
  }

  tags = {
    Name        = each.key
    Environment = var.environment
    Owner       = var.owner
  }
}

resource "aws_instance" "prod_database" {
  ami                    = var.ami_id
  instance_type          = var.instances["prod-database"].instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids
  key_name               = var.instances["prod-database"].key_name

  root_block_device {
    volume_type = var.instances["prod-database"].volume_type
    volume_size = var.instances["prod-database"].volume_size
    encrypted   = true
    iops        = 3000
  }

  tags = {
    Name        = "prod-database"
    Environment = var.environment
    Owner       = var.owner
  }

  lifecycle {
    prevent_destroy = true
  }
}