output "WebServerIP" {
  value       = aws_instance.ec2_wordpress.public_ip
  description = "Web Server IP Address"
}
output "DatabaseName" {
  value       = aws_db_instance.db_wordpress.name
  description = "The Database Name!"
}
output "DatabaseUserName" {
  value       = aws_db_instance.db_wordpress.username
  description = "The Database Name!"
}
output "DBConnectionString" {
  value       = aws_db_instance.db_wordpress.endpoint
  description = "The Database connection String!"
}
