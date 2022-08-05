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
