Imagine you want to run an NGINX web server with 3 replicas in Kubernetes.
- Deployment.yml tells Kubernetes how many NGINX containers you want.
- Service.yml provides a single network endpoint to access those NGINX Pods.


flowchart TB
    USER["User / Browser"]
    NODE["Worker Node IP : NodePort"]
    SVC["NGINX Service<br/>Port 80<br/>Type: NodePort"]
    LB["Service Load Balancing"]

    USER --> NODE
    NODE --> SVC
    SVC --> LB

    subgraph CLUSTER["Kubernetes Cluster"]
      subgraph N1["NGINX Pod 1"]
        P1["NGINX Container<br/>Port 80"]
      end
      subgraph N2["NGINX Pod 2"]
        P2["NGINX Container<br/>Port 80"]
      end
      subgraph N3["NGINX Pod 3"]
        P3["NGINX Container<br/>Port 80"]
      end
      LB --> P1
      LB --> P2
      LB --> P3
    end
