resource "consul_config_entry" "service_resolver" {
  kind = "service-resolver"
  name = "api"

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

resource "consul_config_entry" "service_splitter" {
  kind = "service-splitter"
  name = "api"

  config_json = jsonencode({
    Splits = [
      {
        Weight        = 50
        ServiceSubset = "v1"
      },
      {
        Weight        = 50
        ServiceSubset = "v2"
      },
    ]
  })
}

resource "consul_config_entry" "service_router" {
  kind = "service-router"
  name = "api"

  config_json = jsonencode({
    Routes = [
      {
        Match = {
          HTTP = {
            PathPrefix = "/v1"
          }
        }

        Destination = {
          Service = "api.default.default"
          ServiceSubset = "v1"
        }
      },
      {
        Match = {
          HTTP = {
            PathPrefix = "/v2"
          }
        }

        Destination = {
          Service = "api.default.default"
          ServiceSubset = "v2"
        }
      },
      {
        Match = {
          HTTP = {
            queryParam = {
              name = "version"
              exact = "v1"
            }
          }
        }

        Destination = {
          Service = "api.default.default"
          ServiceSubset = "v1"
        }
      },
      {
        Match = {
          HTTP = {
            queryParam = {
              name = "version"
              exact = "v2"
            }
          }
        }

        Destination = {
          Service = "api.default.default"
          ServiceSubset = "v2"
        }
      }      
      # NOTE: a default catch-all will send unmatched traffic to "web"
    ]
  })
}