## terraform init
- Used it to initialize my teraform folder
- it scans `main.tf` and installs necessary packages
- 

terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
terraform apply --auto-approve
terraform refresh
terraform output
terraform output public_ip_address
terraform plan --destroy
terraform plan -destroy -out=destroy.tfplan
terraform workspace show
terraform workspace list
terraform destroy --auto-approve

2_provisioners
ssh-keygen -t rsa
    saved in:C:\Users\USER/.ssh/terraform

../chmod400.ps1
    saved @ C:\Users\USER\Desktop\code\terraform\chmod400.ps1

### terraform apply --replace="aws_instance.myEc2Demo"

> The terraform apply command is used to apply the changes to the infrastructure as described in the Terraform configuration files. The --replace option is used to force the replacement of a specific resource, in this case aws_instance.myEc2Demo. When you replace a resource with --replace, Terraform will create a new resource to replace the old one, and then delete the old resource after the new one has been created successfully.

> It's important to note that using --replace should be done with caution, as it can have unintended consequences. It's recommended to review the plan carefully before using --replace, and to make sure that the new resource is configured correctly and will not cause any issues with the existing infrastructure.