<img width="1177" height="398" alt="image" src="https://github.com/user-attachments/assets/7bc402d1-159a-4b1e-b237-0220b8888600" />



<img width="1548" height="744" alt="image" src="https://github.com/user-attachments/assets/a032ff59-537d-4a1a-88be-b6b1e6fca816" />

Fleet Manager : to establis the connection b/w two AKS cluster 

<img width="1872" height="464" alt="image" src="https://github.com/user-attachments/assets/59c6a0c5-eb97-4f1a-97d5-ab07bc9631c6" />


### Create a NodePool Menas Worker Nodes 
<img width="1053" height="756" alt="image" src="https://github.com/user-attachments/assets/e566b421-2cb7-45a5-a8d3-7591327cacdc" />
<img width="1232" height="571" alt="image" src="https://github.com/user-attachments/assets/0c5bd7cf-c6d5-4403-96d1-672d0d980bfc" />


### Networking 
<img width="1462" height="787" alt="image" src="https://github.com/user-attachments/assets/e561fb0d-5101-4246-b63e-947ce8f34bf0" />



pod is smalest deployable unit in k8s that runs one or more containers 
Desire state -->

Deployment --> I want 3 copies of my applications alwaus running and no downtime 
no of pods ,scale,replica sets,Image(nginx,custom grow ,apache), upgrades 

Service --> provides stable network endpoint to access a group of pods 

<img width="1381" height="679" alt="image" src="https://github.com/user-attachments/assets/7df7b214-7fff-4c61-9472-cb4b33eaf6eb" />

NameSpace : Logical Isolation of K8s Resources 
$kubectl get ns 
$kubectl create ns samsung 
$kubectl get ns 
