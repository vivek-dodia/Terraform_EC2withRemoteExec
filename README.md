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

## Remote Execution with `remote-exec` Provisioner 🎮

The `remote-exec` provisioner allows you to execute commands on the remote machine once it's up and running. In this project, the following commands are executed remotely on the EC2 instance:

1. **Enable Password Authentication for SSH**: Modifies the SSH configuration to allow password authentication.
    ```bash
    sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
    ```

2. **Restart SSH Service**: Restarts the SSH service to apply the configuration changes.
    ```bash
    sudo systemctl restart sshd
    ```

3. **Install Tailscale**: Installs Tailscale for creating a secure network.
    ```bash
    curl -fsSL https://tailscale.com/install.sh | sh
    ```

4. **Download `bottom` Tool**: Downloads a specific version of the `bottom` system monitoring tool.
    ```bash
    curl -LO https://github.com/ClementTsang/bottom/releases/download/0.9.6/bottom_0.9.6_amd64.deb
    ```

5. **Install `bottom` Tool**: Installs the `bottom` tool if the download was successful.
    ```bash
    sudo dpkg -i bottom_0.9.6_amd64.deb
    ```

### Connection Details 🌐

The `connection` block specifies how Terraform should connect to the instance for remote provisioning. It uses SSH and the following parameters:

- **Type**: SSH
- **User**: `ubuntu`
- **Private Key**: Your SSH private key
- **Host**: Automatically retrieves the public IP of the instance

### How It Works 🤔

Once the EC2 instance is up and running, Terraform uses SSH to execute the above commands on the remote machine. This allows you to automate the initial setup and configuration tasks.

(Note: Make sure your security group and key pair are configured to allow SSH access from your IP address.)



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

