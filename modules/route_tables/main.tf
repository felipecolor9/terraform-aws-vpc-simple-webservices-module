
# Criar Tabela de Roteamento para Subnets Públicas
resource "aws_route_table" "route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = var.rt_cidr_block
    gateway_id = var.internet_gateway_id
  }

  tags = {
    Name  = local.route_table_name
    owner = var.tag_owner
  }
}

# Associar Tabela de Roteamento às Subnets Públicas
resource "aws_route_table_association" "rt_association_1" {
  subnet_id      = var.public_subnet_ids[0]
  route_table_id = aws_route_table.route_table.id
}
resource "aws_route_table_association" "rt_association_2" {
  subnet_id      = var.public_subnet_ids[1]
  route_table_id = aws_route_table.route_table.id
}