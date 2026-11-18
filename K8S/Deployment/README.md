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
