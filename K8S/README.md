Kubernates is a Container Orchestration Platform and it is a opensource 

1. automates the deployment 
2.scaling up and down 
3.management of containerized application 
4.self healing 

### Kubernates Architecture 
 <img width="1081" height="732" alt="image" src="https://github.com/user-attachments/assets/2696e1b6-a378-4f53-85ab-88e46b8544e2" />


### Control Plane – The brain of Kubernetes
<img width="1181" height="681" alt="image" src="https://github.com/user-attachments/assets/4051252d-e2c4-473d-b57c-3c562ccd6bd4" />

### API Server (kube-apiserver)
The API Server is the central communication point of Kubernetes.

All Kubernetes components communicate with the API Server to access or update cluster information.

For example, suppose you execute:
kubectl get pods
What happens?
1. kubectl sends a request to the API Server.
2. API Server receives the request.
3. It retrieves the required cluster information.
4. It returns the response to kubectl.
5. You see the list of Pods.
Important: The API Server is the entry point for Kubernetes management operations.

### etcd 
tcd is the key-value database used by Kubernetes to store cluster state and configuration.

It stores information such as:
- Pod information.
- Node information.
- Deployment configurations.
- Services and networking configuration.
- Cluster state.
Example:

You deploy three replicas of your Spring Boot application.

Kubernetes stores the desired state in its cluster data, including the requested replica count.

etcd is where the API Server persists this information.
Remember: API Server communicates with etcd. Other Kubernetes components generally access cluster state through the API Server rather than directly accessing etcd.

### Controller Manager (kube-controller-manager)
The Controller Manager continuously monitors the cluster and ensures that the actual state matches the desired state.

Example:

You deploy an application with three replicas.
spec:
  replicas: 3

Suppose one Pod crashes.

The Controller Manager's relevant controller detects that the actual number of replicas is now two instead of three and works through the API Server to restore the desired state.

Kubernetes creates another Pod to bring the count back to three.

### Cloud Controller Manager (cloud-controller-manager) 
This component connects Kubernetes with the cloud provider.

For example, when Kubernetes runs on AWS, Azure or Google Cloud, the Cloud Controller Manager helps integrate cloud infrastructure.

Responsibilities can include:
- Managing cloud load balancers.
- Integrating cloud networking.
- Managing cloud-specific node information.
- Integrating cloud storage and infrastructure where supported.

### Scheduler (kube-scheduler)
The Scheduler decides which worker node should run a newly created Pod.

Example:

Suppose your cluster has three worker nodes:
- Node 1: CPU usage is high.
- Node 2: Sufficient CPU and memory.
- Node 3: Sufficient CPU and memory.
You deploy a new Spring Boot Pod.

The Scheduler evaluates available resources and scheduling constraints and selects a suitable node.

Important: The Scheduler selects the node; it does not itself start the container.


### Worker Nodes – Where applications run 
Each Worker Node contains two important Kubernetes components.


### Kubelet 
Kubelet is an agent that runs on every Worker Node.

Its responsibility is to communicate with the API Server and ensure that the containers specified in the assigned Pod specifications are running.

Example:
1. Scheduler selects Node 2 for your Spring Boot Pod.
2. API Server makes the Pod assignment available.
3. Kubelet on Node 2 detects the assigned Pod.
4. Kubelet instructs the container runtime to create and start the containers.
5. Kubelet monitors the Pod and reports its status.
Remember: Kubelet ensures that the required Pods are running on its node.


### Kube-proxy 
Kube-proxy is responsible for implementing Kubernetes Service networking on a node.

It helps route network traffic to the appropriate backend Pods using the networking rules configured on the node.

Example:

You have three Spring Boot application Pods:
- Pod 1 running on Node 1.
- Pod 2 running on Node 2.
- Pod 3 running on Node 3.
You expose them through a Kubernetes Service.

When a client sends a request to that Service, kube-proxy's networking rules help direct the traffic to an appropriate backend Pod.

Remember: Kubelet manages Pods; kube-proxy handles Service-related network traffic.


### Worker Node structure 
<img width="1129" height="481" alt="image" src="https://github.com/user-attachments/assets/c2f8eacb-2842-4f4c-b2d3-83e2c58a9f9a" />


### How all components work together – Real-time example
Deployment request
kubectl apply -f deployment.yaml
API Server receives the request
Validates the deployment request and processes the Kubernetes API operation.

etcd stores the cluster state
The desired configuration is persisted.

Controller Manager monitors the desired state
Ensures that three replicas are created.

Scheduler selects Worker Nodes
Selects suitable nodes for the new Pods.

Kubelet starts the containers
The kubelet on each selected node works with the container runtime to start the assigned Pods.

Kube-proxy handles Service networking
Helps route traffic to the application Pods through the Kubernetes Service.


### What happens if one Pod crashes?
This is one of the most important Kubernetes features.
Kubernetes detects that only two replicas are available and works to create a replacement Pod.
The Deployment Controller (part of the Controller Manager) is responsible for maintaining the desired replica count.
This is called Self-Healing in Kubernetes.


### Quick revision – All components
Component	Responsibility
API Server	Central communication point
etcd	Stores cluster state
Controller Manager	Maintains desired state
Cloud Controller Manager	Cloud infrastructure integration
Scheduler	Selects a Worker Node for Pods
Kubelet	Ensures Pods run on its node
Kube-proxy	Implements Service networking
Container Runtime	Runs containers



Container is nothing but runtime environment 
pod is nothing but kubernates deployment unit 

Deployment 
$kubectl create deployment nginx-deployment --image=nginx 
$kubectl get pods 
$kubectl expose deployment nginx-deployment --type=NodePort  --port=80
$kubectl get svc 
$kubectl get pods  --all-namespaces 
