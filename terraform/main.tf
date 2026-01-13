terraform{
  required_providers {
    gitea = {
      source = "go-gitea/gitea"
      version = "~> 0.7.0"
    }
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 3.6.2"
    }
  }

  required_version = ">= 1.14.3"
}

provider "gitea" {
  base_url= "http://localhost:3000"
  token = "0226869d0015a1bef0ae3f5dcdfbdc41f0cc0722" #this will be loaded as an envar
}

provider "docker"{
}

resource "gitea_repository" "test_repo"{
  username = "testadmin"
  name = "test-repo"
}

resource "docker_image" "nginx" {
  name = "nginx:1.29.4"
}

resource "docker_container" "exam-web-server" {
  image = docker_image.nginx.name
  name = "exam-web-server"
  ports {
    internal = "80"
    external = "8080"
  }
}
