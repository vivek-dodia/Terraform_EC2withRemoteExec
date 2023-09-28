# AWS EC2 Instance with Remote Execution using Terraform 🌍

This Terraform project sets up an EC2 instance on AWS and performs some remote provisioning tasks. 

## Variables 🎛

- `aws_access_key`: Your AWS access key.
- `aws_secret_key`: Your AWS secret key.

## AWS Provider 🛠

Configures the AWS provider with the given `aws_access_key` and `aws_secret_key`. Sets the AWS region to `us-east-1`.

## Resources 🏗

### AWS Key Pair

Creates an AWS key pair with the name `my-keypair` using your public SSH key.

### AWS Instance

Creates an AWS EC2 instance with the following specs:
- AMI: `ami-0fc5d935ebf8bc3bc` (Ubuntu 22.04 LTS for `us-east-1`)
- Instance Type: `t2.micro`
- Key Pair: Uses the key pair created above
- Security Groups: Uses a custom security group defined in this project
- Connection: Connects via SSH for remote provisioning

### AWS Security Group

Creates a security group named `my_security_group` that allows SSH access only from a specific IP address.

## Remote Execution 🎮

After the instance is up and running, the following commands are executed:
- Enable Password Authentication for SSH
- Restart SSH service
- Install Tailscale
- Download and install the `bottom` tool

## How to Run 🏃‍♂️

1. Initialize Terraform

2. Apply Terraform Plan


(Note: Make sure to replace the placeholders for `aws_access_key` and `aws_secret_key` before running the commands.)

## Caution ⚠️

This is a sample Terraform script. Please ensure you understand the effects of running this script on your AWS environment.

