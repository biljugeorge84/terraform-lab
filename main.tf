terraform {
  required_version = ">=1.15"

  cloud {
        organization = "Bilju-Kyndryl-Demo"
    workspaces {
      name = "terraform-lab"
    }
  }
}

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.47.0"
    }
     }


provider "aws" {
  region = "ap-south-1"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  count = 3
  tags = {
    Name = "Bilju-tes-${count.index}"
  }
}
