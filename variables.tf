#########################
###        VPC        ###
#########################

variable "vpc_name" {
  description = "VPC name for"
  default     = "SAACO3-VPC"
}

#########################
###      SUBNETS      ###
#########################

variable "region_number" {
  description = "Assign a number to each region used in our configuration"
  default = {
    sa-east-1 = 1
  }
}
variable "az_number" {
  description = "Assign a number to each AZ letter used in our configuration"
  default = {
    a = 1
    b = 2
    c = 3
  }
}

#########################
###    CIDR BLOCKS    ###
#########################

variable "cidr_block" {
  description = "CIDR block for VPC"
  default     = "10.0.0.0/21"
}

variable "rt_cidr_block" {
  description = "Value for route table CIDR block"
  default     = "0.0.0.0/0"
}

variable "private_subnets_cidr_blocks" {
  description = "list of ip blocks availables for the subnets"
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "public_subnets_cidr_blocks" {
  description = "list of ip blocks availables for the subnets"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

#########################
###      GENERAL      ###
#########################

variable "tag_owner" {
  description = "owner of the resource in cloud provider"
  type        = string
  default     = "felipemarques"
}