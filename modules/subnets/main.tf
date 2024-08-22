# Cria subnets privadas
resource "aws_subnet" "private_subnet" {
  count             = length(var.private_subnets_cidr_blocks)
  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnets_cidr_blocks[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names)]

  tags = {
    Name  = "${local.private_subnet_prefix}_${count.index + 1}"
    owner = var.tag_owner
  }
}

# Cria subnets publicas
resource "aws_subnet" "public_subnet" {
  count                   = length(var.public_subnets_cidr_blocks)
  vpc_id                  = var.vpc_id
  cidr_block              = var.public_subnets_cidr_blocks[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names)]
  map_public_ip_on_launch = true

  tags = {
    Name  = "${local.public_subnet_prefix}_${count.index + 1}"
    owner = var.tag_owner
  }
}

data "aws_availability_zones" "available" {}


