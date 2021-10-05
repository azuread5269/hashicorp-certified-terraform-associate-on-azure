locals {
  environment = "pwazure5269"
}

locals {
  nsg_inbound_ports_map = {
    "101" : "80"
    "102" : "5985"
    "103" : "5986"
  }
}
