resource "consul_config_entry" "web" {
  name = "web"
  kind = "service-defaults"
  partition = var.partition
  config_json = jsonencode({
        Protocol = "http"
        Namespace = "default"
        UpstreamConfig = {
            Defaults = {
                MeshGateway = {
                    Mode = "local"
                }
                Limits = {
                    MaxConnections = 512,
                    MaxPendingRequests = 512,
                    MaxConcurrentRequests = 512
                }
            }
        }
  })
}

resource "consul_config_entry" "api-v1" {
  name = "api-v1"
  kind = "service-defaults"
  partition = var.partition
  config_json = jsonencode({
        Protocol = "http"
        Namespace = "default"
        UpstreamConfig = {
            Defaults = {
                MeshGateway = {
                    Mode = "local"
                }
                Limits = {
                    MaxConnections = 512,
                    MaxPendingRequests = 512,
                    MaxConcurrentRequests = 512
                }
            }
        }
  })
}
