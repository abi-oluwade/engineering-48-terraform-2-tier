# App tier outputs

output "app_security_group_id" {
  description = "the id for the security group that will house the apps"
  value = "${aws_security_group.app_security_group.id}"
}
