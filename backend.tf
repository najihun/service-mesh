terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "najihun"

    workspaces {
      name = "service-mesh"
    }
  }
}
