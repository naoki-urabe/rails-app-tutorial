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

resource "aws_network_interface" "for-tutorial-network-interface" {
  subnet_id = aws_subnet.for-tutorial-public-subnet.id
  tags = {
    Name = "for-tutorial-network-interface"
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_instance" "instance" {
  ami           = "ami-0f36dcfcc94112ea1"
  instance_type = "t2.micro"
  network_interface {
    network_interface_id = aws_network_interface.for-tutorial-network-interface.id
    device_index         = 0
  }
}