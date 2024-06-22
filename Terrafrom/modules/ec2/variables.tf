variable "sg_id" {
  description = "SG id for EC2"
  type =  string
}

variable "subnets" {
  description = "Subnet ID for EC2"
  type = list(string)
}

variable "ec2_names" {
    description = "EC2 Names"
    type = list(string)
    default = [ "Webserver1","Webserver2" ]
}