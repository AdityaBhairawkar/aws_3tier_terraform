output "frontend_public_ip" {
  value = aws_instance.frontend.public_ip
}

output "rds_endpoint" {
  value = aws_db_instance.main.endpoint
}

output "backend_public_ip" {
  value = aws_instance.backend.private_ip
}
