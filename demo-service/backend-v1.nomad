job "fake-api-v1" {
   datacenters = ["dc1"]
   constraint {
    attribute = "${attr.unique.network.ip-address}"
    value     = "10.0.0.5"
   }
   group "fake-api-v1" {
     network {
       mode = "bridge"
     }

     service {
       name = "api"
       port = "9091"
       tags = ["v1"]
       meta {
        version = "v1"
       }

       connect {
         sidecar_service {}
       }

       check {
        expose = true
        type = "http"
        name = "api-health"
        path = "/"
        interval = "10s"
        timeout = "3s"
       }
  
     }

     task "api" {
       driver = "docker"
       config {
         image = "nicholasjackson/fake-service:v0.24.2"
       }
       env {
            LISTEN_ADDR = "127.0.0.1:9091"
            NAME = "api-v1"
            MESSAGE = "Response from API v1"
       }
     }
   }
 }