resource "kubernetes_deployment" "external-deployment" {
  metadata {
    name = "events-web"
    labels = {
      App = "events-web"
    }
    namespace = kubernetes_namespace.n.metadata[0].name
  }

  spec {
    replicas                  = 4
    progress_deadline_seconds = 60
    selector {
      match_labels = {
        App = "events-web"
      }
    }
    template {
      metadata {
        labels = {
          App = "events-web"
        }
      }
      spec {
        container {
          image = "poojadocker912/external:v3.0.0" 
          name  = "events-web"
          env {
            name  = "SERVER"
            value = "http://events-data-service:8082"
          }          
          port {
            container_port = 8080
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