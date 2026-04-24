provider "aws" {
  region = "ap-south-1"
}

# Get latest Amazon Linux AMI
data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }
}

# Security Group
resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow SSH and HTTP"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg"
  }
}

# EC2 Instance
resource "aws_instance" "demo" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  key_name = "terraform-key"

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              set -x

              yum update -y
              yum install -y docker

              systemctl start docker
              systemctl enable docker

              usermod -aG docker ec2-user

              docker run -d -p 80:80 ragav5/devops-demo
              EOF

  tags = {
    Name = "terraform-auto-docker"
  }
}

# Output public IP
output "public_ip" {
  value = aws_instance.demo.public_ip
}