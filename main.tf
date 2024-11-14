provider "aws" {
  region = "eu-central-1"
}

# EC2 Instance
resource "aws_instance" "meineErsteInstanz" {
  ami           = "ami-0eddb4a4e7d846d6f"
  instance_type = "t2.micro"
  tags = {
    Name = "DasIstDerWorkflow"
  }
}

# VPC
resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "main_vpc"
  }
}

# Subnet
resource "aws_subnet" "main_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-central-1a"
  tags = {
    Name = "main_subnet"
  }
}

# S3 Bucket
resource "aws_s3_bucket" "data_bucket" {
  bucket = "mein-s3-bucket"   # Name des Buckets. Sollte einzigartig sein
  acl    = "private"          # Setze den Bucket auf privat
  tags = {
    Name = "data_bucket"
  }
}

# RDS Instance
resource "aws_db_instance" "my_rds" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  db_name              = "mydatabase"    # Korrektes Attribut für den Datenbanknamen
  username             = "admin"
  password             = "your_password" # Nutze am besten einen Secrets Manager für Passwörter
  publicly_accessible  = false
  skip_final_snapshot  = true
  tags = {
    Name = "my_rds_database"
  }
}
