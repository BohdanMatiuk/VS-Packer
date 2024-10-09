packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "Packer_block" {
  ami_name      = "my_golden_image {{timestamp}}"
  instance_type = "t2.micro"
  region        = "us-east-2"
  source_ami="ami-09da212cf18033880"
  ssh_username = "ec2-user"
  ssh_private_key_file = "~/.ssh/id_rsa"
  ssh_keypair_name = "vs-packer-key"
}

build {
  name    = "name_build_block"
  sources = [
    "source.amazon-ebs.Packer_block"
  ]

  provisioner "shell" {
    script = "script.sh"
  }
}
