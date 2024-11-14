terraform {
  backend "s3" {
    bucket = "ralf-state-bucket"
    key    = "github-action-.tfstate"
    region = "eu-central-1"
  }
}

