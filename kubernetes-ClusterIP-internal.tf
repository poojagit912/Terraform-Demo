resource "kubernetes_service" "internal-service" {
  metadata {
    name      = "events-data-service"
    namespace = kubernetes_namespace.n.metadata[0].name
  }
  spec {
    selector = {
      App = kubernetes_deployment.internal-deployment.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 8082
      target_port = 8082
    }

    type = "ClusterIP"
  }
}

#output "cluster_ip" {
 # value = kubernetes_service.events-data-service.load_balancer_ingress[0].ip
#}