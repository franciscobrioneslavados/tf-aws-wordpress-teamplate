# GENERAL
variable "access_key" {
  type        = string
  description = "aws region"
  default     = ""
}

variable "secret_key" {
  type        = string
  description = "aws region"
  default     = ""
}

variable "region" {
  type        = string
  description = "aws region"
  default     = "us-east-1"
}

# Application definition
variable "app_name" {
  type        = string
  description = "Application name"
}

# Application environment
variable "app_environment" {
  type        = string
  description = "Application environment"
}


# AWS RDS
variable "db_name" {
  type    = string
  default = "db_wordpress"
}

variable "db_username" {
  type    = string
  default = "terraform"
}

variable "db_password" {
  type    = string
  default = "terraform"
}


# AWS AZ
variable "aws_az" {
  type        = string
  description = "AWS AZ"
  default     = "us-east-1a"
}

# VPC Variables
variable "vpc_cidr" {
  type        = string
  description = "CIDR for the VPC"
}

# Subnet Variables
variable "public_subnet_cidr" {
  type        = string
  description = "CIDR for the public subnet"
}



# Ec2 Variables
variable "linux_instance_type" {
  type        = string
  description = "EC2 instance type for Linux Server"
  # default     = "t1.micro" #t2.nano, t2.micro
}

variable "linux_associate_public_ip_address" {
  type        = bool
  description = "Associate a public IP address to the EC2 instance"
  # default     = true
}

