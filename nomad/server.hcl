# Full configuration options can be found at https://www.nomadproject.io/docs/configuration

data_dir  = "/opt/nomad/data"
bind_addr = "0.0.0.0"

server {
  # license_path is required as of Nomad v1.1.1+
  license_path = "/opt/nomad/nomad.lic"
  enabled          = true
  bootstrap_expect = 1
}

consul {
  #address  = "127.0.0.1:8500"
  address  = "10.0.0.4:8500"
  grpc_address = "10.0.0.4:8502"
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