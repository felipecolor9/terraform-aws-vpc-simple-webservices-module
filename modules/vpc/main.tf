# Criar VPC
resource "aws_vpc" "vpc" {

  cidr_block           = var.cidr_block
  instance_tenancy     = "default"
  enable_dns_support   = true //default is true
  enable_dns_hostnames = true //default is true

  tags = {
    owner = var.tag_owner
    Name  = var.vpc_name
  }
}
