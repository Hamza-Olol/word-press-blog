variable "azs" {
  type    = list
  default = ["eu-north-1a"]
}

variable "cidr-range" {
  type    = string
  default = "10.0.0.0/28"
}

variable "public-subnet" {
  type    = list(string)
  default = ["10.0.0.0/28"]
}
