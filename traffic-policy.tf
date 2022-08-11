resource "consul_config_entry" "service_resolver" {
  kind = "service-resolver"
  name = "gs-backend"

  config_json = jsonencode({

    Subsets = {
      "v1" = {
        Filter = "Service.Meta.version == v1"
      }
      "v2" = {
        Filter = "Service.Meta.version == v2"
      }
    }
  })
}
