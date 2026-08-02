terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # 0단계에서 만든 S3와 DynamoDB 이름 입력
  backend "s3" {
    bucket         = "my-app-tfstate-123456" # 본인이 생성한 S3 버킷명
    key            = "dev/terraform.tfstate"
    region         = "ap-northeast-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = "ap-northeast-2"
}

module "web_app" {
  source        = "../../modules/web_app"
  env           = var.env
  vpc_cidr      = var.vpc_cidr
  instance_type = var.instance_type
}