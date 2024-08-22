# Criar Internet Gateway
resource "aws_internet_gateway" "igtw" {
  vpc_id = var.vpc_id

  tags = {
    Name = local.internet_gtw_name
  }
}
