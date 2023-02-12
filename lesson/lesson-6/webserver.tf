#------------------------
#my webserver
#by Denis Leibovich
#------------------------

provider "aws" {
  region = "us-east-2"
}

resource "aws_default_vpc" "default" {}

resource "aws_eip" "my_static_ip" {
  instance = aws_instance.my_webserver.id
  vpc      = true # Need to add in new AWS Provider version
  tags = {
    Name  = "Web Server IP"
    Owner = "Denis Leibovich"
  }
}



resource "aws_instance" "my_webserver" {
  ami                    = "ami-0568773882d492fc8"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  user_data = templatefile("user_data.sh.tpl", {
    f_name = "Denis"
    l_name = "Leibobich"
    names  = ["vasye", "kolfay", "levana", "serge0", "vera"]
  })

  tags = {
    Name  = "My Server Build by Terraform"
    Owner = "Denis Leibovich"
  }

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_security_group" "my_webserver" {
  name        = "WebServer Security Group"
  description = "My First SecurityGroup"



  dynamic "ingress" {
    for_each = ["80", "443"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Web Server SecurityGroup"
    Owner = "Denis Leibovich"
  }
}
