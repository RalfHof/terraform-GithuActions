terraform {
  backend "s3" {
    bucket = "ralf-state-bucket"
    key    = "github-action-key"
    region = "eu-central-1"
  }
}
