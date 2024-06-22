variable "sg_id" {
    description = "This is the SG id for Application Load balancer"
    type = string
}

variable "subnets"  {
    description = "This is the subnet id for Application Load balancer"
    type = list(string)
}



variable "vpc_id" {
    description = "VPC_id for ALB"
    type = string
}



variable "instance" {
    description = "Instance ID for tg attachment"
    type = list(string)
}