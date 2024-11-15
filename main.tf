provider "aws" {
  region = "eu-central-1"
}

# Erstellt EC2-Instance
resource "aws_instance" "meineErsteInstanz" {
  count = 3
  ami           = "ami-0eddb4a4e7d846d6f"
  instance_type = "t2.micro"
  key_name = "terraformKey"
  vpc_security_group_ids = [aws_security_group.ssh_access.id]
  tags = {
    Name = "Meine Github Actions ${count.index}"
  }
}

# Security Group erstellen (nur SSH-Zugriff)
resource "aws_security_group" "ssh_access" {
  name_prefix = "ssh-access"
  description = "Allow SSH access"
 

  ingress {
    
    from_port   = 22
    to_port     = 22
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
    Name = "SSH_Access"
  }
}


output "instance_puplic_ips" {
  value = [aws_instance.meineErsteInstanz.*.public_ip]
}