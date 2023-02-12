#------------------------
#my webserver
#by Denis Leibovich
#------------------------

provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "my_linux_server" {
  ami                    = "ami-0568773882d492fc8"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.My_webserver.id]
  user_data = templatefile("user_data.sh.tpl", {
    f_name = "Denis"
    l_name = "Leibobich"
    names  = ["vasye", "kolay", "levana", "serge0", "vera"]
  })

  tags = {
    Name    = "My Ubuntu 2 server"
    Owner   = "Denis Leibovich"
    Project = "Terraform lessons"
  }

}

resource "aws_security_group" "My_webserver" {
  name        = "WebServer Security Group"
  description = "My First SecurityGroup"


  ingress {
    description = "TLS from VPC"
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


}
