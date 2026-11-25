
<img width="1576" height="736" alt="image" src="https://github.com/user-attachments/assets/b51d28a7-4b4c-4f64-8ab9-66ea5bad514f" />


we need a metric server to monitor nods and pods 

need to install metric servers 
$kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
$kubectl get pods -A -w
