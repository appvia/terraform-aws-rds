variable "name" {
  description = "The name of the database you want to create"
  type        = string
}

variable "environment" {
  description = "The name of the environment you are provisioning in"
  type        = string
}

variable "instance" {
  description = "The instance defines the instance class which should be used by the database"
  type        = string
  default     = "db.t3.medium"
}

variable "storage" {
  description = "The size in megabytes of the storage device you want to use"
  type        = number
  default     = 10
}

variable "database_username" {
  description = "The username to create when provisioning the database"
  type        = string
  default     = "root"
}

variable "database_password" {
  description = "The database password to use for this database"
  type        = string
  default     = ""
}
