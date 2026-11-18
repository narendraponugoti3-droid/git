Imagine you want to run an NGINX web server with 3 replicas in Kubernetes.
- Deployment.yml tells Kubernetes how many NGINX containers you want.
- Service.yml provides a single network endpoint to access those NGINX Pods.

###  First understand the architecture
<img width="745" height="625" alt="image" src="https://github.com/user-attachments/assets/12a8b880-383c-4c08-a018-1f0b298ce5a1" />

Think of it like this:
1. You create a Deployment.
2. Kubernetes creates 3 NGINX Pods.
3. You create a Service.
4. The Service finds the 3 Pods using labels.
5. Users access the application through the Service.
6. Service networking distributes requests across the available Pods.

### Deployment.yml – Create 3 NGINX Pods

apiVersion: apps/v1
kind: Deployment

metadata:
  name: nginx

spec:
  replicas: 3

  selector:
    matchLabels:
      app: nginx-web

  template:
    metadata:
      labels:
        app: nginx-web

    spec:
      containers:
        - name: nginx
          image: nginx
          ports:
            - containerPort: 80
### Explanation line by line
YAML property	Simple meaning
apiVersion: apps/v1	Kubernetes Deployment API version
kind: Deployment	We are creating a Deployment
metadata.name: nginx	Deployment name
replicas: 3	Run 3 Pods
selector.matchLabels	Find Pods with the matching label
template	Template used to create Pods
labels.app: nginx-web	Give each Pod this label
containers	Define containers inside the Pod
name: nginx	Container name
image: nginx	Download and run NGINX Docker image
containerPort: 80	The application listens on port 80


### What happens when you deploy this file?
kubectl apply -f deployment.yml
Kubernetes performs the following operations:
<img width="728" height="618" alt="image" src="https://github.com/user-attachments/assets/d72c28fe-55d6-4ab9-8cd2-f27440607c36" />

###  Service.yml – Connect users to the 3 Pods
The Deployment creates Pods, but how can users access those Pods?
That's where a Kubernetes Service comes in.
Here is your corrected Service YAML:


apiVersion: v1
kind: Service

metadata:
  name: nginx-web-service

spec:
  selector:
    app: nginx-web

  type: NodePort

  ports:
    - port: 80
      targetPort: 80
### How does Service identify the 3 Pods? 
In your Deployment:
labels:
  app: nginx-web

Every Pod receives the same label.
In your Service:

selector:
  app: nginx-web

The Service looks for Pods with that matching label.
<img width="1123" height="313" alt="image" src="https://github.com/user-attachments/assets/7936e3cf-3022-4a60-8ac5-0eae025903be" />

Remember: The Deployment creates Pods. The Service identifies the Pods using labels and provides a stable network endpoint.

### Complete flow – Deployment + Service together
<img width="891" height="602" alt="image" src="https://github.com/user-attachments/assets/94bc13f9-e4dd-42d2-afe7-1569191fc222" />


For example, a user accesses:
http://<Worker-Node-IP>:30080


The request follows this path:
1. User sends an HTTP request.
2. Worker Node receives the request on the NodePort.
3. Kubernetes Service receives the traffic.
4. Service forwards it to one of the available NGINX Pods.
5. NGINX processes the request and returns the response.
The NodePort 30080 is an example. Kubernetes normally allocates a NodePort automatically from its configured range (default 30000–32767).

### How to execute your YAML files
Step 1: Create Deployment
    kubectl apply -f deployment.yml
Step 2: Create Service
  kubectl apply -f service.yml
Step 3: Check Pods
   kubectl get pods
Step 4: Check Deploymen
  kubectl get deployments
Step 5: Check Service
   kubectl get services
Step 6: Access NGINX
http://<Worker-Node-IP>:30080

### Important difference – Deployment vs Service 
Deployment	                            Service
Creates and manages Pods	            Provides network access to Pods
Maintains replica count   	          Selects matching Pods
Manages application updates 	        Provides a stable IP/DNS
Restarts/replaces failed Pods
through its controller	              Routes traffic to available endpoints



kubectl create deployment nginx --replicas=3 --image=nginx

The one concept to remember:
- Deployment = Creates and manages your application Pods.
- Service = Connects users to those Pods.
- Labels and selectors = Help the Service find the correct Pods.
