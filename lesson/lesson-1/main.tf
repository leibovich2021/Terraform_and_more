provider "aws" {
  region     = "us-east-2"
}

resource "aws_instance" "linux" {
  ami           = "ami-0568773882d492fc8"
  instance_type = "t3.micro"

  tags = {
    Name     = "My linux server"
    Owner    = "Denis Leibovich"
    Project  = "Terraform lessons"
  }
}
