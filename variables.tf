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

variable "database_engine" {
  description = "The database engine you want to use, i.e MySQL, Postgres, etc"
  type        = string
  default     = "mysql"
}

variable "database_engine_version" {
  description = "The version of the database engine you want to use"
  type        = string
  default     = "5.7.25"
}

variable "database_family" {
  description = "The family of the database engine you want to use"
  type        = string
  default     = "mysql5.7"
}

variable "database_backup_window" {
  description = "The time window you want to perform maintenance in"
  type        = string
  default     = "03:00-06:00"
}

variable "database_major_engine_version" {
  description = "The major version of the database engine you want to use"
  type        = string
  default     = "5.7"
}

variable "database_options" {
  description = "The time window you want to perform maintenance in"
  type = list(object({
    name  = string
    value = string
  }))
  dafault = [
    {
      option_name = "MARIADB_AUDIT_PLUGIN"
      option_settings = [
        {
          name  = "SERVER_AUDIT_FILE_ROTATIONS"
          value = "37"
        },
        {
          name  = "SERVER_AUDIT_EVENTS"
          value = "CONNECT"
        },
      ]
    },
  ]
}

variable "database_parameters" {
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

variable "database_password" {
  description = "The database password to use for this database"
  type        = string
  default     = ""
}

variable "backup_retention_period" {
  description = "The number of days to keep backups for"
  type        = number
  default     = 1
}
