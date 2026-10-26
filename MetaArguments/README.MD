### terraform Meta Arguments 
------------------------------
1. What are Terraform meta-arguments?
Terraform meta-arguments are special arguments that control how Terraform creates, manages, updates, and deletes resources.

1. count --- create multiple instances
2. for_each --- create instances from a map or set
3. depends_on --- declare an explicit dependency
4.lifecycle --- control resource lifecycle behavior
Meta Arguments  - it controls how terraform manages the resource

count: 3
name="rg-${count.index}"

for_each --> loop over map/set 

{dev,qa,prod}
name=rg-${each.key}

DependsOn: 

VM--> RG 
depends_on=[azurerm_resource_group.rgi]


Lifecycle: 
it will control the behaviour like create/update/delete 
ifecycle{
prevent_destroy=true
ignore_changes=[size,tags]


Provider: azurerm,aws,gcp 
Provisioner(deplricated)
Cloud init :

### 


