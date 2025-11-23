output "frontend_public_ip" {
  description = "Public IP of the frontend instance."
  value       = aws_instance.frontend.public_ip
}

output "frontend_url" {
  description = "URL to access the frontend."
  value       = "http://${aws_instance.frontend.public_ip}"
}

output "backend_private_ip" {
  description = "Private IP of the backend instance."
  value       = aws_instance.backend.private_ip
}

output "db_endpoint" {
  description = "RDS endpoint."
  value       = aws_db_instance.main.endpoint
}
