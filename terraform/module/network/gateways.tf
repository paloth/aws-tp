#### internet gateway creation
resource "aws_internet_gateway" "self" {
  vpc_id = aws_vpc.self.id

  tags = merge(var.tags, {
    Name = "${var.environment}-${var.application}"
    }
  )
}

#### Elastic IP creation
resource "aws_eip" "nat_gateway" {
  vpc = true
}

#### Nat gateway creation
resource "aws_nat_gateway" "self" {
  allocation_id = aws_eip.nat_gateway.id
  subnet_id     = element(aws_subnet.public.*.id, 1)

  tags = merge(var.tags, {
    Name = lower("${var.environment}-${var.application}-nat-gateway")
    }
  )
}
