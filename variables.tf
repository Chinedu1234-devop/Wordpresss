variable "region" {
  default = "eu-west-2"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "db_username" {
  default = "wpuser"
}

variable "db_password" {
  default = "wppassword123"
}

variable "key_name" {
  description = "Your EC2 key pair name"
  default = "mykey.pem"
}