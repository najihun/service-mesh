provider "consul" {
  address    = var.consul_addr
  datacenter = var.dc_name
}

resource "consul_config_entry" "ingress_gateway" {
  name = "ingress-gateway"
  kind = "ingress-gateway"
  namespace = "default"
  partition = var.partition
  config_json = jsonencode({
    Listeners = [
    {
      Port     = 9090
      Protocol = "http"
      Services = [{ Name  = "web-na", Hosts = ["*"]}]
    }
    ]
  })
}

# resource "consul_config_entry" "proxy_defaults" {
#   kind = "proxy-defaults"
#   name = "global"

#   config_json = jsonencode({
#     Config = {
#       local_connect_timeout_ms = 1000
#       handshake_timeout_ms     = 10000
#     }
#   })
# }


resource "consul_config_entry" "exported_services_k8s" {
    name = "k8s"
    kind = "exported-services"
    partition = "k8s"
    config_json = jsonencode({
        Services = [{
            Name = "web-na"
            Namespace = "default"
            Consumers = [{
                Partition = "default"
            }]
        }]
    })
}

resource "consul_config_entry" "exported_services_vm" {
    name = "default"
    kind = "exported-services"
    partition = "default"
    config_json = jsonencode({
        Services = [{
            Name = "api"
            Namespace = "default"
            Consumers = [{
                Partition = "k8s"
            }]
        }]
    })
}