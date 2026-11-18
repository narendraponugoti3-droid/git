# Create AKS Cluster 

<img width="640" height="484" alt="image" src="https://github.com/user-attachments/assets/2c9b02d9-a5ae-471a-a42a-cb34a426caf0" />



### Services 
Service : Provides stable network endpoint to access a group of pods 
### ClusterIP : Default Service type in K8S 
It is used for internal communication inside a K8S Cluster 
<img width="1222" height="385" alt="image" src="https://github.com/user-attachments/assets/56aebfd0-53c0-451f-9b1e-88f0d77c2c05" />
``` xml
$kubectl get pods 
$kubectl get pods -A
$kubectl get node
$kubectl create deployment nginx --image=nginx --replicas=2
$kubectl create deployment apache --image=httpd --replicas=2
$kubectl get pods -o wide 
$kubectl expose deployment nginx  --port=80 --type=ClusterIP
$kubectl expose deployment apache  --port=80 --type=ClusterIP

$kubectl get svc 
```
Create a new pod for netwrok troubleshoot (netshoot image ) 
$kubectl run netshoot --image=nicolaka/netshot -it -rm --bash 
$curl http://10.0.80.170   // this apache pod Ip address 

<img width="1893" height="592" alt="image" src="https://github.com/user-attachments/assets/f0046ba1-4c81-425a-9406-62e8a905ed74" />


### NodePort Service 

<img width="1420" height="666" alt="image" src="https://github.com/user-attachments/assets/ffff7007-b3bf-4b2e-8349-aa0053654db6" />
$kubectl get node -o wide 

Interivew Question : 
how to convert the clusterIP to NodePort 
$kubectl patch svc nignx  -p '{"spec":"NodePort"}}'

<img width="1848" height="597" alt="image" src="https://github.com/user-attachments/assets/941241ed-0bf8-483d-8723-4a34a5cd4c58" />

### Load Balancer service 
<img width="1666" height="554" alt="image" src="https://github.com/user-attachments/assets/f32c655c-1f2a-49ae-8dd7-2351b534b6ba" />

Calico CNI --> does not hold any public IPs , we generally avoid punlic Ip Address 
if you need public IP , go to F5 ,metal LB, HA Proxy 

### 4. Real-world example
# Deployment
containerPort: 8080

# Service
ports:
  - port: 80
    targetPort: 8080

Kubernetes Service
80
Service port

Forwards traffic
targetPort: 8080

Spring Boot Container
8080
Application listening port

A user accesses the Service on port 80, but the request reaches Spring Boot on port 8080.

This is very common when deploying Spring Boot applications.
### 5. Remember these three ports
Property	Purpose	Example
containerPort	Container port	8080
targetPort	Destination container port	8080
port	Service port	80
nodePort	Worker Node external port (NodePort Service)	30080

