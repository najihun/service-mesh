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
                passive_health_check = {
                    interval     = "30s"
                    max_failures = 10
                }
            }
        }
  })
}

resource "consul_config_entry" "web-na" {
  name = "web-na"
  kind = "service-defaults"
  partition = "k8s"
  config_json = jsonencode({
        Protocol = "http"
        Namespace = "default"
        UpstreamConfig = {
            Defaults = {
                MeshGateway = {
                    Mode = "local"
                }
                passive_health_check = {
                    interval     = "15s"
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
            }
        }
  })
}

resource "consul_config_entry" "api-v1" {
  name = "api-v1"
  kind = "service-defaults"
  partition = "k8s"
  config_json = jsonencode({
        Protocol = "http"
        Namespace = "default"
        UpstreamConfig = {
            Defaults = {
                MeshGateway = {
                    Mode = "local"
                }
            }
        }
  })
}

resource "consul_config_entry" "cache" {
  name = "cache"
  kind = "service-defaults"
  partition = "k8s"
  config_json = jsonencode({
        Protocol = "http"
        Namespace = "default"
        UpstreamConfig = {
            Defaults = {
                MeshGateway = {
                    Mode = "local"
                }
            }
        }
  })
}
