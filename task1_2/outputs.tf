output "instance_ids" {
  value = merge(
    { for name, instance in aws_instance.regular : name => instance.id },
    { "prod-database" = aws_instance.prod_database.id }
  )
}

output "private_ips" {
  value = merge(
    { for name, instance in aws_instance.regular : name => instance.private_ip },
    { "prod-database" = aws_instance.prod_database.private_ip }
  )
}