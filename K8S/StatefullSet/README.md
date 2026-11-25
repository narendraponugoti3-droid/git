



### K8S Node 
$sudo mkdir -p /data/mysql-0 /data/mysql-1  /data/mysql-2
$kubectl apply -f secret.yml 
$kubectl describe secret mysql-scret 

$kubectl apply -f storageclass.yml
$kubectl apply -f service.yml
$kubectl apply -f statefullset.yml 
$kubectl get pods -n dev -w 
$kubectl get pods -n dev 
Connect to SQL Pod
$kubectl exec -it mysql-0 -n dev -- mysql -uroot -p 

trace the pod actions using -w
$kubectl get pods -n dev -w

$kubectl delete pod mysql-o -n dev 
Scale the statefull set 
$kubectl scale statefullset mysql -n dev --replicas=3 
Then Create the mysql1 , now will check it 

$kubectl exec -it mysql-1 -n dev -- mysql -uroot -pPassword123 -e "show database"
<img width="1590" height="325" alt="image" src="https://github.com/user-attachments/assets/e66d9225-377d-4312-9312-f06bb6b7e7b7" />

<img width="1727" height="474" alt="image" src="https://github.com/user-attachments/assets/7d1dbf83-b4d8-47b7-8409-65cf76b0e2d0" />
