variable "allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = number
  default     = 20
}

variable "allowed_cidr_blocks" {
  description = "The CIDR blocks you want to allow access to the RDS instance"
  type        = map(string)
  default     = {}
}

variable "backup_retention_period" {
  description = "The number of days to keep backups for"
  type        = number
  default     = 1
}

variable "backup_window" {
  description = "The time window you want to perform backups in"
  type        = string
  default     = "01:00-03:00"
}

variable "db_name" {
  description = "The name of the database you want to create"
  type        = string
}

variable "engine" {
  description = "The database engine you want to use i.e mysql, postgres, etc"
  type        = string
  default     = "mysql"
}

variable "engine_version" {
  description = "The version of the database engine you want to use"
  type        = string
  default     = "8.0"
}

variable "family" {
  description = "The family of the database engine you want to use"
  type        = string
  default     = "mysql8.0"
}

variable "instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
  default     = "db.t3.micro"
}

variable "license_model" {
  description = "The license model you want to use for the database"
  type        = string
  default     = "license-included"
}

variable "maintenance_window" {
  description = "The time window you want to perform maintenance in"
  type        = string
  default     = "Mon:04:00-Mon:06:00"
}

variable "major_engine_version" {
  description = "The major version of the database engine you want to use"
  type        = string
  default     = "8.0"
}

variable "parameters" {
  description = "The options you want to use for the database"
  type = list(object({
    name  = string
    value = string
  }))
  default = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]
}

variable "port" {
  description = "The port the database should listen on"
  type        = number
  default     = 3306
}

variable "storage_encrypted" {
  description = "Whether the database should be encrypted"
  type        = bool
  default     = true
}

variable "subnet_ids" {
  description = "The Subnet IDs you want to use for the RDS instance"
  type        = list(string)
}

variable "tags" {
  description = "The tags you want to apply to the RDS instance"
  type        = map(string)
}

variable "username" {
  description = "The username you want to use for the database"
  type        = string
  default     = "root"
}

variable "vpc_id" {
  description = "The VPC ID that the RDS instance will be within"
  type        = string
}
