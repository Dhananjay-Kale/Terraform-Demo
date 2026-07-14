variable "vpc-cidr" {
  default = "10.0.0.0/16"
}

variable "private_cidr" {
  default = "10.0.0.0/20"
}

variable "public_cidr" {
  default = "10.0.16.0/20"
}
variable "az1" {
  default = "ap-south-1a"
}

variable "az2" {
  default = "ap-south-1b"
}

variable "project_name" {
  default = "tcs"
}
variable "IGW-cidr" {
  default = "0.0.0.0/0"
}
variable "ami" {
  default = "ami-0b910d1016287a5e7" 
}
variable "key" {
  default = "devops-key"
}
variable "instance_type" {
  description = "Enter instance type"
  default = "t3.micro"
}