variable "aws_access_key" {}
variable "aws_secret_key" {}

provider "aws" {
  region     = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_key_pair" "my_keypair" {
  key_name   = "my-keypair"
  public_key = file("C:\\Users\\Vivek\\.ssh\\id_rsa.pub")
}

resource "aws_instance" "my_instance" {
  ami           = "ami-0fc5d935ebf8bc3bc"  // Ubuntu 22.04 LTS AMI ID for us-east-1
  instance_type = "t2.micro"
  key_name      = aws_key_pair.my_keypair.key_name
  
  security_groups = [aws_security_group.my_security_group.name]

  connection {
    type        = "ssh"
    user        = "ubuntu"  # Use the appropriate username for your AMI
    private_key = file("C:\\Users\\Vivek\\.ssh\\id_rsa")  # Provide the path to your private key
    host        = self.public_ip  # Use self.public_ip to automatically retrieve the public IP
  }

  provisioner "remote-exec" {
  inline = [
    "sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config",
    "sudo systemctl restart sshd",
    "curl -fsSL https://tailscale.com/install.sh | sh",
    "curl -LO https://github.com/ClementTsang/bottom/releases/download/0.9.6/bottom_0.9.6_amd64.deb",
    "if [ -f bottom_0.9.6_amd64.deb ]; then",
    "  sudo dpkg -i bottom_0.9.6_amd64.deb",
    "else",
    "  echo 'Error: bottom_0.9.6_amd64.deb not found'",
    "fi"
  ]
}
}

resource "aws_security_group" "my_security_group" {
  name        = "my_security_group"
  description = "My security group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["68.173.179.95/32"]
  }
}
