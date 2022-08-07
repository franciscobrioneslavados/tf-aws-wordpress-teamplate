/* 
resource "aws_db_instance" "db_wordpress" {

  instance_class      = "db.t3.micro"
  engine              = "mysql"
  publicly_accessible = false
  allocated_storage   = 20
  name                = var.db_name
  username            = var.db_username
  password            = var.db_password
  skip_final_snapshot = true
  tags = {
    app = "tf_db_wordpress"
  }
} */
