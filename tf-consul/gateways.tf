provider "consul" {
  address    = var.consul_addr
  datacenter = var.dc_name
}

resource "consul_config_entry" "ingress_gateway" {
  name = "ingress-gateway"
  kind = "ingress-gateway"
  namespace = "default"
  partition = "k8s"
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

## Open Tracing
# resource "consul_config_entry" "proxy_defaults" {
#   kind = "proxy-defaults"
#   name = "global"

#   config_json = jsonencode({
#     MeshGateway = {
#       Mode = "local"
#     }
    
#     Config = {
#         envoy_extra_static_clusters_json = {
#             connect_timeout = "3.000s"  
#             dns_lookup_family = "V4_ONLY"
#             lb_policy = "ROUND_ROBIN"
#             load_assignment = {
#                 cluster_name = "jaeger_collector"
#                 endpoints = [{        
#                     lb_endpoints = [{
#                         endpoint = {
#                             address = {
#                                 socket_address = {
#                                     address = "10.0.0.8"
#                                     port_value = "9411"
#                                     protocol = "http"
#                                 }
#                             }
#                         }          
#                     }]      
#                 }]  
#             }
#             name = "jaeger_collector"
#             type = "STRICT_DNS"
#         }

#         envoy_tracing_json = {
#             http = {
#                 name = "envoy.tracers.zipkin"
#                 typedConfig = {
#                     "@type" = "type.googleapis.com/envoy.config.trace.v3.ZipkinConfig"
#                     collector_cluster = "jaeger_collector"
#                     collector_endpoint_version = "HTTP_JSON"
#                     collector_endpoint = "/api/v2/spans"
#                     shared_span_context = false    
#                 }  
#             }
#         }
#         protocol = "http"
#     }
#   })
# }

resource "consul_config_entry" "proxy_defaults" {
  kind = "proxy-defaults"
  # Note that only "global" is currently supported for proxy-defaults and that
  # Consul will override this attribute if you set it to anything else.
  name = "global"

  config_json = jsonencode({
    MeshGateway = {
      Mode = "local"
    }
    Config = {
      Protocol = "http"
    }
  })
}



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
