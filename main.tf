terraform {
  required_version = ">=1.15"

  cloud {
        organization = "terraform-kyndryl-gcp"
    workspaces {
      name = "terraform-aws-cli"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.47.0"
    }
    google = {
        source = "hashicorp/google"
    }
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
  count = 2
  tags = {
    Name = "HelloWorld-${count.index}"
  }
}
