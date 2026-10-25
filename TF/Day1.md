<img width="1357" height="549" alt="image" src="https://github.com/user-attachments/assets/cd0c41dc-954e-49ce-8671-4c307c0168bd" />
<img width="1307" height="722" alt="image" src="https://github.com/user-attachments/assets/c5b8a7a7-5841-40e4-a1d9-05cf2c7f789d" />


Interview Question : Explain Teraform workflow 
Azure : ARM templates/Bicep 
AWS : Cloud Formation 

State file : track all resource which you used terraform to create resoruces 

Install Azure CLI :
Then Open Command Prompt 
$az --version

$az login --use-device-code

$az account show 

Install AWS CLI 
Login AWS --> Create a User and attach policies directly with adminstrator --> Click terraform-user --> Create Acess key 
Select CLI 

Then Open Command Prompt 
$aws configure 
aws access key id:
aws secret access key: 
Default region name: ap-south-2
Default output format: json 

$aws sts get-caller-identity

Install Terraform 
VS code : install terraform plugin hashcorp 


### Terraform workflow 
# Terraform StateFile
--------------------------
Terraform state file : 
A Terraform state file is a file that Terraform uses to remember the infrastructure
it manages and map your Terraform configuration to real resources in your cloud or environment.

The default filename is terraform.tfstate.

$terraform apply , what happen 
Create the resources and then terraform.tfstate(updates)
<img width="1115" height="480" alt="image" src="https://github.com/user-attachments/assets/b317ddf0-5f1d-45ae-a148-ade253ca16f4" />
$terraform apply --auto-approve 
