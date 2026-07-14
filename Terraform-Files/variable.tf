#2nd highest priority in terms of assignment

#define variable
variable "ami" {
  default = "ami-0b910d1016287a5e7"  #assign the value
}

variable "instance_type" {
  description = "Enter instance type"
  default = "t3.micro"
}

variable "az" {
  description = "enter AZ"
  default = "ap-south-1a"
}

variable "key" {
  default = "devops-key"
}