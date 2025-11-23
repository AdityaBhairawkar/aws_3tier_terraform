# Security Group for Frontend
resource "aws_security_group" "frontend_sg" {
  name        = "${var.project_name}-frontendsg"
  description = "Allow HTTP, HTTPS & SSH (restricted)"
  vpc_id      = aws_vpc.main.id

  # HTTP
  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS
  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH from YOUR IP only
  ingress {
    description = "Allow SSH from your IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_allowed_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-frontendsg"
  }
}

# Security Group for Backend
resource "aws_security_group" "backend_sg" {
  name        = "${var.project_name}-backendsg"
  description = "Allow traffic from frontend and SSH from public subnets"
  vpc_id      = aws_vpc.main.id

  # Flask API from frontend
  ingress {
    description     = "Flask API from frontend"
    from_port       = 5000
    to_port         = 5000
    protocol        = "tcp"
    security_groups = [aws_security_group.frontend_sg.id]
  }

  # SSH from Public Subnets
  ingress {
    description = "Allow SSH from Public Subnets"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.public_subnet_cidrs
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "${var.project_name}-backendsg"
  }
}

# Security Group for RDS (Database)
resource "aws_security_group" "db_sg" {
  name        = "${var.project_name}-dbsg"
  description = "Allow MySQL from backend"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "MySQL from Backend"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.backend_sg.id]
  }

  egress {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-dbsg"
  }
}
