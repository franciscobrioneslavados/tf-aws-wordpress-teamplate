#####################################
## Virtual Machine Module - Output ##
#####################################

output "vm_linux_server_instance_id" {
  value = aws_instance.ec2_wordpress.id
}

output "vm_linux_server_instance_public_dns" {
  value = aws_instance.ec2_wordpress.public_dns
}

output "vm_linux_server_instance_public_ip" {
  value = aws_eip.linux-eip.public_ip
}

output "vm_linux_server_instance_private_ip" {
  value = aws_instance.ec2_wordpress.private_ip
}
