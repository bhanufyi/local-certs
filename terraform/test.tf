locals {
  list1 = ["a", "b", "c"]
  list2 = ["x", "y", "z"]
  temp_vms = flatten([for i in local.list1:[
			for j in local.list2: {
	  							value1 = i
	  							value2 = j
							}		
]])
}


output "temp_vms" {
	value = local.temp_vms
}

# resource "example_resource" "example" {
#   for_each = temp_vms

#   value1 = each.value.value1
#   value2 = each.value.value2
# }