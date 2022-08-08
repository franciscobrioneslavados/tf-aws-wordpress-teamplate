output "vm_linux_server_ami_id" {
  value = data.aws_ami.amazon_linux_2.id
}

output "vm_linux_server_ami_name" {
  value = data.aws_ami.amazon_linux_2.name
}

output "vm_linux_server_ami_description" {
  value = data.aws_ami.amazon_linux_2.description
}

output "vm_linux_server_instance_id" {
  value = aws_instance.ec2_instance[0].id
}

output "vm_linux_server_instance_public_dns" {
  value = aws_instance.ec2_instance[0].public_dns
}

output "vm_linux_server_instance_public_ip" {
  value = aws_eip.ec2_eip.public_ip
}

output "vm_linux_server_instance_private_ip" {
  value = aws_instance.ec2_instance[0].private_ip
}

output "endpoint_rds" {
  value = aws_db_instance.db_wordpress.endpoint
}

output "name_rds" {
  value       = aws_db_instance.db_wordpress.name
  description = "The Database Name!"
}

output "username_rds" {
  value       = aws_db_instance.db_wordpress.username
  description = "The Database Username!"
}

output "password_rds" {
  value       = aws_db_instance.db_wordpress.password
  description = "The Database Username!"
  sensitive   = true
}
