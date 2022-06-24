output "FRONT" {
  value = aws_instance.front
}

output "APPS" {
  value = aws_instance.apps
}
output "PUBLIC-IP" {
  value = aws_eip.sgp_eip
}

output "RDS" {
  sensitive = true
  value = module.db.db_master_password
}