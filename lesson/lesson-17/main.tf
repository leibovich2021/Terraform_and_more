provider "aws" {
  region = "ca-central-1"
}


variable "aws_users" {
  description = "List of IAM User to create"
  default     = ["denis1", "denis2", "denis3", "denis4", "denis5", "denis6", ]
}



resource "aws_iam_user" "user1" {
  name = "Levana"
}
resource "aws_iam_user" "users" {
  count = length(var.aws_users)
  name  = element(var.aws_users, count.index)
}
output "created_iam_users_all" {
  value = aws_iam_user.users
}


output "created_iam_users_ids" {
  value = aws_iam_user.users[*].id
}

output "created_iam_users_custom" {
  value = [
    for user in aws_iam_user.users :
  "Hello Username : ${user.name} has ARN : ${user.arn}"]
}

output "created_iam_users_map" {
  value = {
    for user in aws_iam_user.users :
    user.unique_id => user.id
  }
}

# output "custom_if_length" {
#   value = [
#     for x in aws_iam_user.users:
#     x.name
#     if lenght(x.name) ==4
#   ]
# }


#----------------------------------------------

resource "aws_instance" "servers" {
  count         = 3
  ami           = "ami-046a5648dee483245"
  instance_type = "t3.micro"
  tags = {
    Name = "Server Number ${count.index + 1}"
  }
}
output "server_all" {
  value = {
    for server in aws_instance.servers :
    server.id => server.public_ip
  }
}
