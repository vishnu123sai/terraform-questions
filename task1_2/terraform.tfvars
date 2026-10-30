ami_id = "ami-REPLACE_WITH_YOUR_AMI"
subnet_id = "subnet-REPLACE_WITH_YOUR_SUBNET"

security_group_ids = ["sg-REPLACE_WITH_YOUR_SG"]

environment = "dev"
owner       = "DevOps"

instances = {
  web-server = {
    instance_type = "t3.micro"
    volume_type   = "gp3"
    volume_size   = 10
    key_name      = "web-key"
  }

  app-server = {
    instance_type = "t3.small"
    volume_type   = "gp2"
    volume_size   = 20
    key_name      = "app-key"
  }

  batch-worker = {
    instance_type = "t3.medium"
    volume_type   = "io1"
    volume_size   = 60
    key_name      = "batch-key"
  }

  cache-server = {
    instance_type = "t3.large"
    volume_type   = "standard"
    volume_size   = 40
    key_name      = "cache-key"
  }

  prod-database = {
    instance_type = "m6i.large"
    volume_type   = "io2"
    volume_size   = 50
    key_name      = "database-key"
  }
}