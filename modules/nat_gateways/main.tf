
# Criar Elastic IP Address
resource "aws_eip" "nat" {
}
resource "aws_eip" "nat2" {
}

# Criar NAT Gateway
resource "aws_nat_gateway" "nat_gtw_1" {
  allocation_id = aws_eip.nat.id
  subnet_id     = var.public_subnet_ids[0] # Subnet pública para o NAT Gateway
  tags = {
    Name  = local.nat_gateways_names[0]
    owner = var.tag_owner
  }
}

resource "aws_nat_gateway" "nat_gtw_2" {
  allocation_id = aws_eip.nat2.id
  subnet_id     = var.public_subnet_ids[1] # Subnet pública para o NAT Gateway
  tags = {
    Name  = local.nat_gateways_names[1]
    owner = var.tag_owner
  }
}