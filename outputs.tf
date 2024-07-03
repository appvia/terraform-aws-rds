output "database_name" {
  description = "The name of the database created"
  value       = module.rds.db_instance_name
}

output "database_host" {
  description = "The hostname to use to connect to the database"
  value       = module.rds.db_instance_address
}

output "database_endpoint" {
  description = "The hostname to use to connect to the database"
  value       = module.rds.db_instance_endpoint
}

output "database_port" {
  description = "The port to use to connect to the database"
  value       = module.rds.db_instance_port
}

output "database_user" {
  description = "The username to use to connect to the database"
  value       = module.rds.db_instance_username
  sensitive   = true
}

output "database_password" {
  description = "The password to use to connect to the database"
  value       = random_password.password.result
  sensitive   = true
}
