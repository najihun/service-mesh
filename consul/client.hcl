data_dir = "/opt/consul"

client_addr = "0.0.0.0"

datacenter = "ebay"

# client
server = false

# Bind addr
bind_addr = "0.0.0.0" # Listen on all IPv4
# Advertise addr - if you want to point clients to a different address than bind or LB.
advertise_addr = "10.0.0.5"

# Enterprise License
license_path = "/opt/consul/consul.lic"

# encrypt
encrypt = "7w+zkhqa+YD4GSKXjRWETBIT8hs53Sr/w95oiVxq5Qc="

# retry_join
retry_join = ["10.0.0.4"]

//ca_file = "/opt/consul/consul-agent-ca.pem"
//cert_file = "/opt/consul/ebay-client-consul-0.pem" 
//key_file = "/opt/consul/ebay-client-consul-0-key.pem"

verify_incoming = false
verify_incoming_rpc = false
verify_outgoing = false
verify_server_hostname = false

ports {
  http = 8500
  dns = 8600
  https = -1
  serf_lan = 8301
  grpc = 8502
  server = 8300
  serf_wan = 8302
//  sidecar_min_port = 21000
//  sidecar_max_port = 21255
//  expose_min_port = 21500
//  expose_max_port = 21755
}

connect {
  enabled = true
}

log_level = "DEBUG"
log_file = "/opt/consul/consul.log"
log_rotate_duration = "24h"
log_rotate_bytes = 104857600
log_rotate_max_files = 100