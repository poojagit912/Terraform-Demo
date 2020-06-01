resource "kubernetes_deployment" "internal-deployment" {
  metadata {
    name = "events-data"
    labels = {
      App = "events-data"
    }
    namespace = kubernetes_namespace.n.metadata[0].name
  }

  spec {
    replicas                  = 1
    progress_deadline_seconds = 60
    selector {
      match_labels = {
        App = "events-data"
      }
    }
    template {
      metadata {
        labels = {
          App = "events-data"
        }
      }
      spec {
        container {
          image = "poojadocker912/internal:v1.0.0"
          name  = "events-data"

          port {
            container_port = 8082
          }

          resources {
            limits {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests {
              cpu    = "0.1"
              memory = "256Mi"
            }
          }
        }
      }
    }
  }
}