variable "db_password" {
  description = "RDS user password"
  type = string
  sensitive = true
}

variable "db_host" {
  description = "RDS db host."
}