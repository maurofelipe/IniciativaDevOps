terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.21.0"
    }
  }
}

provider "digitalocean" {
  # Configuration options
  token = var.digi_token
}

resource "digitalocean_kubernetes_cluster" "k8s_iniciativa_devops" {
  name   = var.k8s_name
  region = var.digi_region
  version = var.k8s_version

  node_pool {
    name       = "worker-pool-homolog"
    size       = "s-1vcpu-2gb"
    node_count = 2
  }
}

output "k8s_endpoint" {
  value = digitalocean_kubernetes_cluster.k8s_iniciativa_devops.endpoint
}

resource "local_file" "kube_config" {
    content  = digitalocean_kubernetes_cluster.k8s_iniciativa_devops.kube_config.0.raw_config
    filename = "kube_config.yaml"
}

