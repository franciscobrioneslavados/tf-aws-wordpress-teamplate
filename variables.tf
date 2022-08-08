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
  default     = ""
}

# Application definition
variable "app_name" {
  type        = string
  description = "Application name"
  default     = ""
}

# Application environment
variable "app_environment" {
  type        = string
  description = "Application environment"
  default     = ""
}


# AWS RDS
variable "db_name" {
  type        = string
  description = "value"
  default     = ""
}

variable "db_username" {
  type        = string
  description = "value"
  default     = ""
}

variable "db_password" {
  type        = string
  description = "value"
  default     = ""
}


# VPC Variables
variable "vpc_cidr_block" {
  type        = string
  description = "CIDR for the VPC"
  default     = "10.0.0.0/16"
}

# Subnet Variables
variable "subnet_count" {
  description = "Number subnet"
  type        = map(number)
  default = {
    public  = 1,
    private = 2,
  }
}

# This Variables contains the CIDR blocks for the public subnet. 
variable "public_subnet_cidr_blocks" {
  description = "Availabel CIDR blocks for public subnets"
  type        = list(string)
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24",
    "10.0.4.0/24",
  ]
}

# This Variables contains the CIDR blocks for the private subnet. 
variable "private_subnet_cidr_blocks" {
  description = "Availabel CIDR blocks for public subnets"
  type        = list(string)
  default = [
    "10.0.101.0/24",
    "10.0.102.0/24",
    "10.0.103.0/24",
    "10.0.104.0/24",
  ]
}

# Ec2 Variables
variable "linux_instance_type" {
  type        = string
  description = "EC2 instance type for Linux Server"
  default     = "t1.micro" #t2.nano, t2.micro
}
