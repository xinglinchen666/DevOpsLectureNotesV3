module "myApp" {
  source = "./staging/services/backend_app"
  app_version = var.app_version
}