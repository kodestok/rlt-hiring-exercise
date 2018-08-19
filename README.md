Solution to the infrastructure Coding Test
==========================================

# Infrastructure

Infrastructure will be provisioned using Hashicorp's Terraform tool in the us-west-2 region (Oregon).

AWS resources that will be created for the Coding Test:

* VPC
* Subnets
* Routing Table
* Security Groups
* ELB
* EC2
* SSH key
* Internet Gateway

# Prerequisites to use Terraform

* AWS account with admin priviledges, AWS_ACCESS_KEY & AWS_SECRET_KEY need to be populted in the terraform.tfvars file
* Public and private SSH keys 


# Instructions

1. Populate AWS_ACCESS_KEY & AWS_SECRET_KEY into the terraform.tfvars file.
2. Generate SSH keys, use 'mykey' as the name and place the keys in the same folder as .tf files. Do not use passphrase:
	* $ssh-keygen -t rsa mykey
3. Run:
	* terraform init
	* terraform plan
	* terraform apply

4. Terraform will output EC2 instance public IP address and ELB DNS address to the terminal and also export EC2 public IP address to the instance_public_ip.txt file.
	* Verify if you can access NGINX in your web browser using addresses from the Terraform output.
	* Also verify if /version.txt file can be served, by using output addresses - http://address/version.txt

	* Bootstrap Bash script will install and run NGINX on the EC2 instance.
	* Bash script will also add all Docker prerequisites (repo, packages, etc.) and install it on EC2.
	* Docker will run MySQL Server in the container and expose port 3306 to the public.

# Other

* To login to EC2 instance please use 'ubuntu' username, remember to use private key while login into the instance.
	* Verify if MySQL Server is running in a Docker container by running 'sudo docker ps -a' command.

* checker.sh script will SSH into the EC2 and check if the server version equals to 1.0.6. Script will use EC2's public IP address that was saved earlier in the instance_public_ip.txt file. Script will also verify if Nginx process is running. If the process is not running it will start it.

* connect_to_ec2.sh script will connect you to the EC2 instance.


