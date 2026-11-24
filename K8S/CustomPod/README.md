<img width="1278" height="733" alt="image" src="https://github.com/user-attachments/assets/5792980a-9558-48c9-a52d-e9b341695a7e" />

```yaml 
ACR : Azure container registory 

folder ( .net application+docker file )-->copy into docker VM -->  docker (application) using wniscp and docker image --> push into ACR 
K8S is Running --> deployment and serivvce (create custom pod ) pull the image from ACR 

Step1 : Create VM for Docker and then install the docker 
$ssh devopsuser@public_ip
$sudo su -
docker installation one command 
$curl -fsSL https://get.docker.com -o get-docker.sh && sudo sh get-docker.sh


Step2: Create another VM for K8S and isntall K8s script

vi installk8s.sh
$chmod 700 installk8s.sh
$./installk8s.sh

Step3 : using winscp , then copy the python code into Docker VM (root/tmp)
$cd tmp/
$cd GrowLP 
build the docker file 
$docker build -t growlp:v1 -f dockerfile . 
$docker images 

Step4: Create a ACR in Azure( search COntainer Registry)

Step5 : Now you want to push docker image to ACR 
Docker VM and ACR , there is no relation , how to push the docker image from Docker VM to ACR 
we need to install Azure CLI in DOcker VM 
$az --version 
install azure cli on Docker VM 
$ curl -sSL 'https://azurecliprod.blob.core.windows.net/$root/deb_install.sh' | sudo bash
$az --version 
$az login --use-device-code 
Now log in azure ACR 
$ az acr login --name growlp.azurecr.io   ( login sername in acr )
$az acr list -o table 
now push the image to ACR 

$docker build -t 
$docker tag -t
```
<img width="1146" height="329" alt="image" src="https://github.com/user-attachments/assets/3e86f39d-6c8b-4872-9f13-c1e162a238bd" />


$docker tag growlp:v1 growwlp.azurecr.io/growwlp:v1.0.0
<img width="1919" height="216" alt="image" src="https://github.com/user-attachments/assets/64b55266-ebe7-4e73-8af4-69d2a5733221" />

### push the docker from Docker VM to ACR 
$docker push growwlp.azurecr.io/growwlp:v1.0.0


### Pull the docker image from ACR to K8S 
we need to pull the docker image from ACR to K8s , you need to perform  the authentication b/w Azure Devops and Azure CLoud
```yaml
go to ACR  --> IAM --> Add Role Assignment --> AcrPull 
then Go to Kubernate VM 
$sudo su -
install AZ CLI 
$curl -sSL 'https://azurecliprod.blob.core.windows.net/$root/deb_install.sh' | sudo bash
$az login --use-device-code
Then Create a Service Principle 
$az ad sp create-for-rback --name "groww-acr-pull"  --role acrpull  --scopes //subscriptions/eb2e4db/resourcegroup/kuberg/providers/
  /Microsoft.ContainerRegistry/registries/growwlp 

```
<img width="1919" height="140" alt="image" src="https://github.com/user-attachments/assets/d50150c2-39d2-467f-a31d-c6a1999674a6" />

<img width="1919" height="459" alt="image" src="https://github.com/user-attachments/assets/8042513f-b44b-4b73-a306-c647cf520d32" />
$kubectl create secret docker-registry  acr-secret --docker-server=growwlp.azurecr.io  --docker-username=AppId  
    --docker-password=password  --docker-email=

<img width="1899" height="691" alt="image" src="https://github.com/user-attachments/assets/f27f6a2b-58fd-4224-88b1-3a045baf37a5" />
