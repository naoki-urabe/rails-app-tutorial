resource "aws_vpc" "for-tutorial" {
  cidr_block = "11.0.0.0/16"
  tags = {
    Name = "for-tutorial"
  }
}

resource "aws_subnet" "for-tutorial-public-subnet" {
  vpc_id            = aws_vpc.for-tutorial.id
  cidr_block        = "11.0.0.0/24"
  availability_zone = "ap-northeast-1a"
  tags = {
    Name = "for-tutorial-network-interface"
  }
}

resource "aws_internet_gateway" "for-rails-tutorial" {
  vpc_id = aws_vpc.for-tutorial.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.for-tutorial.id
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.for-rails-tutorial.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.for-tutorial-public-subnet.id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "for-rails-tutorial" {
  name        = "for-rails-tutorial"
  description = "for rails tutorial"
  vpc_id      = aws_vpc.for-tutorial.id
  ingress {
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
}

provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_instance" "instance" {
  subnet_id                   = aws_subnet.for-tutorial-public-subnet.id
  ami                         = "ami-0f36dcfcc94112ea1"
  instance_type               = "t2.micro"
  key_name                    = "udemysample"
  security_groups             = [aws_security_group.for-rails-tutorial.id]
  associate_public_ip_address = true
  user_data                   = <<EOF
  #!/bin/bash
  sudo yum update 
  sudo yum install -y docker
  sudo service docker start
  EOF
  tags = {
    AutoStop = true
  }
}