job "fake-api-v2" {
   datacenters = ["dc1"]
   constraint {
    attribute = "${attr.unique.network.ip-address}"
    value     = "10.0.0.5"
   }
   group "api-v2" {
     network {
       mode = "bridge"
     }

     service {
       name = "api"
       port = "9091"
       tags = ["v2"]
       meta {
        version = "v2"
       }

       connect {
         sidecar_service {}
       }

       check {
        expose = true
        type = "http"
        name = "api-v2-health"
        path = "/"
        interval = "10s"
        timeout = "3s"
       }
  
     }

     task "api" {
       driver = "docker"
       config {
         image = "nicholasjackson/fake-service:v0.23.1"
       }
       env {
            LISTEN_ADDR = "127.0.0.1:9091"
            NAME = "api-v1"
            MESSAGE = "Response from API v2"
       }
     }
   }
 }