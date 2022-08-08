resource "aws_db_instance" "db_wordpress" {

  instance_class      = "db.t3.micro"
  engine              = "mysql"
  engine_version      = "5.7"
  publicly_accessible = true
  allocated_storage   = 20
  db_name             = var.db_name
  username            = var.db_username
  password            = var.db_password
  skip_final_snapshot = true
  tags = {
    app = "tf_db_wordpress"
  }
  availability_zone = var.aws_az
}


# Define the security group for the rds
resource "aws_security_group" "aws-rds-sg" {
  name        = "${lower(var.app_name)}-${var.app_environment}-rds-sg"
  description = "Allow incoming MYSQL connections"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${lower(var.app_name)}-${var.app_environment}-linux-sg"
    Environment = var.app_environment
  }
}
