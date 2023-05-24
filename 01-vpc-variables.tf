variable "azs" {
  type    = list(any)
  default = ["eu-north-1a", "eu-north-1b"]
}

variable "cidr-range" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public-subnet" {
  type    = list(string)
  default = ["10.0.0.0/28", "10.0.0.16/28"]
}

variable "db-subnet" {
  type    = list(string)
  default = ["10.0.1.0/28", "10.0.1.16/28"]
}

variable "create_database_subnet_group" {
  type    = bool
  default = true
}

variable "create_database_subnet_route_table" {
  type    = bool
  default = true
}

variable "create_database_nat_gateway_route" {
  type    = bool
  default = true
}

variable "create_database_internet_gateway_route" {
  type    = bool
  default = true
}
