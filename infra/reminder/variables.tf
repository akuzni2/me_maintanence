variable "db_password" {
  description = "RDS user password"
  type = string
  sensitive = true
}

variable "db_host" {
  description = "RDS db host."
}

variable "tf_state_bucket" {
  description = "state bucket for resources"
  type        = string
}