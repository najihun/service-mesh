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

                passive_health_check = {
                    interval     = "30s"
                    max_failures = 10
                }
            }
        }
  })
}

resource "consul_config_entry" "api" {
  name = "api"
  kind = "service-defaults"
  partition = "default"
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

