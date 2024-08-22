terraform {
  required_version = ">=1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "bucket-remote-state-estudos"
    key    = "aws-vpc/terraform.tfstate"
    region = "sa-east-1"
  }
}

# Configure AWS Provider
provider "aws" {
  region = "sa-east-1"

  default_tags {
    tags = {
      owner      = var.tag_owner
      managed-by = "terraform"
    }
  }
}

module "vpc" {
  source     = "./modules/vpc"
  cidr_block = var.cidr_block
  vpc_name   = var.vpc_name
  tag_owner  = var.tag_owner
}

module "subnets" {
  source                      = "./modules/subnets"
  public_subnets_cidr_blocks  = var.public_subnets_cidr_blocks
  private_subnets_cidr_blocks = var.private_subnets_cidr_blocks
  vpc_name                    = var.vpc_name
  vpc_id                      = module.vpc.vpc_id

  tag_owner     = var.tag_owner
  region_number = var.region_number
  az_number     = var.az_number
}

module "route_tables" {
  source              = "./modules/route_tables"
  vpc_name            = var.vpc_name
  tag_owner           = var.tag_owner
  rt_cidr_block       = var.rt_cidr_block
  internet_gateway_id = module.internet_gateway.igtw_id
  vpc_id              = module.vpc.vpc_id
  public_subnet_ids   = module.subnets.public_subnet_ids


}

module "internet_gateway" {
  source    = "./modules/internet_gateway"
  vpc_id    = module.vpc.vpc_id
  vpc_name  = var.vpc_name
  tag_owner = var.tag_owner

}

module "nat_gateways" {
  source            = "./modules/nat_gateways"
  vpc_name          = var.vpc_name
  tag_owner         = var.tag_owner
  public_subnet_ids = module.subnets.public_subnet_ids
}

module "security_groups" {
  source    = "./modules/security_groups"
  vpc_name  = var.vpc_name
  vpc_id    = module.vpc.vpc_id
  tag_owner = var.tag_owner

  private_subnets_cidr_blocks = var.private_subnets_cidr_blocks
  public_subnets_cidr_blocks  = var.public_subnets_cidr_blocks
}