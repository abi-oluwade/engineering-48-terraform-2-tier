output "db-instance-private-ip" {
  value = aws_instance.db_instance.private_ip
}
