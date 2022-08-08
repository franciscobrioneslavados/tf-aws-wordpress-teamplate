resource "aws_db_subnet_group" "wp_db_subnet_group" {
  name       = "wordpress_database_subnet_group"
  subnet_ids = [for subnet in aws_subnet.private_subnet : subnet.id]
}

# Define the security group for the rds
resource "aws_security_group" "wp_db_sg" {
  name        = "${lower(var.app_name)}-${var.app_environment}-rds-sg"
  description = "Security group for wordpress database"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description     = "Allow DB traffic from only the server wordpress"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_sg.id]
  }

  tags = {
    Name        = "${lower(var.app_name)}-${var.app_environment}-linux-sg"
    Environment = var.app_environment
  }
}


resource "aws_db_instance" "db_wordpress" {
  instance_class         = "db.t3.micro"
  engine                 = "mysql"
  engine_version         = "5.7"
  publicly_accessible    = true
  allocated_storage      = 20
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.wp_db_subnet_group.id
  vpc_security_group_ids = [aws_security_group.wp_db_sg.id]
  skip_final_snapshot    = true
  tags = {
    app = "wp_db_wordpress"
  }
}


