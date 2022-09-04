# Full configuration options can be found at https://www.nomadproject.io/docs/configuration

data_dir  = "/opt/nomad/data"
bind_addr = "0.0.0.0"

client {
  enabled = true
  servers = ["10.0.0.4"]
  #meta {
  # connect.sidecar_image = "envoyproxy/envoy:v1.21.3"
  #}

  
}

consul {
  address  = "10.0.0.5:8500"
  grpc_address="10.0.0.5:8502"
  server_service_name = "nomad"
  client_service_name = "nomad-client"
  auto_advertise  = true
  server_auto_join  = true
  client_auto_join  = true
}

log_level = "DEBUG"
log_file = "/opt/nomad/nomad.log"
log_rotate_duration = "24h"
log_rotate_bytes = 104857600
log_rotate_max_files = 100