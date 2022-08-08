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

# This variable contains the configuration
# settings for the EC2 and RDS instances
variable "settings" {
  description = "Configuration settings"
  type        = map(any)
  default = {
    "database" = {
      allocated_storage   = 10             // storage in gigabytes
      engine              = "mysql"        // engine type
      engine_version      = "8.0.27"       // engine version
      instance_class      = "db.t2.micro"  // rds instance type
      db_name             = "db_wordpress" // database name
      skip_final_snapshot = true
    },
    "web_app" = {
      count         = 1          // the number of EC2 instances
      instance_type = "t1.micro" // the EC2 instance
    }
  }
}
