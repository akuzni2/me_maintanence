variable "db_password" {
  description = "RDS root user password"
  type        = string
  sensitive   = true
}

variable "tf_state_bucket" {
  description = "state bucket for resources"
  type        = string
}