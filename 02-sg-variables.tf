variable "my-ip" {
  type    = list(any)
  default = ["86.0.0.0/8"]
}

variable "internal-cidr" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}