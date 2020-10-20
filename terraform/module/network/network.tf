resource "aws_vpc" "self" {
  cidr_block = var.cidr_block

  tags = merge(var.tags, {
    Name = "${var.environment}-${var.application}"
    }
  )
}

#### public subnet creation
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.self.id
  count                   = length(data.aws_availability_zones.available.names)
  cidr_block              = cidrsubnet(aws_vpc.self.cidr_block, var.netbits, count.index + var.public_networks_prefix + 1)
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)
  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name = "${var.environment}-${var.application}-public-${count.index + 1}"
    }
  )
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.self.id

  tags = merge(var.tags, {
    Name = lower("${var.environment}-${var.application}-public")
    }
  )
}

resource "aws_route_table_association" "public" {
  count          = length(data.aws_availability_zones.available.names)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route" "internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.self.id
}

#### Private subnet route table creation

resource "aws_subnet" "private" {
  vpc_id                  = aws_vpc.self.id
  count                   = length(data.aws_availability_zones.available.names)
  cidr_block              = cidrsubnet(aws_vpc.self.cidr_block, var.netbits, count.index + var.private_networks_prefix + 1)
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)
  map_public_ip_on_launch = false

  tags = merge(var.tags, {
    Name = "${var.environment}-${var.application}-private-${count.index + 1}"
    }
  )
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.self.id

  tags = merge(var.tags, {
    Name = lower("${var.environment}-${var.application}-private")
    }
  )
}

resource "aws_route_table_association" "private" {
  count          = length(data.aws_availability_zones.available)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private.id
}

resource "aws_route" "nat_gateway" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.self.id
}
