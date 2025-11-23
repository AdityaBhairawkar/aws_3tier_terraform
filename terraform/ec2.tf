# Key Pair
resource "tls_private_key" "ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "deploy" {
  key_name   = "${var.project_name}-key"
  public_key = tls_private_key.ec2_key.public_key_openssh
}

resource "local_file" "private_key" {
  content         = tls_private_key.ec2_key.private_key_pem
  filename        = "${path.module}/3tier-app-key.pem"
  file_permission = "0400"
}

# Backend Instance (Private Subnet)
resource "aws_instance" "backend" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private[0].id
  vpc_security_group_ids = [aws_security_group.backend_sg.id]
  key_name               = aws_key_pair.deploy.key_name
  associate_public_ip_address = false

  user_data = templatefile("${path.module}/backend_userdata.sh.tpl", {
    RDS_ENDPOINT      = split(":", aws_db_instance.main.endpoint)[0]
    RDS_USERNAME      = var.rds_username
    RDS_PASSWORD      = var.db_password
    RDS_DATABASE_NAME = var.rds_db_name
  })

  tags = {
    Name = "${var.project_name}-backend"
  }
}

# Frontend Instance (Public Subnet)
resource "aws_instance" "frontend" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public[0].id
  vpc_security_group_ids      = [aws_security_group.frontend_sg.id]
  key_name                    = aws_key_pair.deploy.key_name
  associate_public_ip_address = true

  user_data = templatefile("${path.module}/frontend_script.sh.tpl", {
    backend_ip = aws_instance.backend.private_ip
  })

  tags = {
    Name = "${var.project_name}-frontend"
  }
}
