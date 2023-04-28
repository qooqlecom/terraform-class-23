variable "instance_name" {
  type = string
  description = "Enter Instance name"
  default = "kaizen"
}

variable "machine_type" {
  type = string
  description = "Enter Machine type"
  default = "e2-medium"
}

variable "zone" {
    type = string
  description = "Enter zone"
  default = "us-central1-a"
  
}

