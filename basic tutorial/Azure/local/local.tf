resource "local_file" "pet" {
    filename = "myfile.txt"
    content = "hello there"
  
}

variable "test" {
  type = set(string)
  default = [ "bob","harry" ]
}

resource "local_file" "pet1" {
    filename = each.value 
  for_each = var.resource_group_name2
  
}

resource "local_file" "pet2" {
    filename = each.value
  for_each = var.test
  
}

output "get_list" {
    value = [for i in var.resource_group_name1: i ]
}

