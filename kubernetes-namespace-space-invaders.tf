resource "kubernetes_namespace" "n" {
  metadata {
    name = "internal-external"
  }
}