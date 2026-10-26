### terraform backend and CICD  

Interview Importent 

every time terraform state file should moved to S3 backend 
terraform backend is place where TF stores and manages the state --> local laptop ,AWS S3, Azure AS
terraform.tfstate
<img width="1113" height="472" alt="image" src="https://github.com/user-attachments/assets/13afc49d-465e-44f2-a3cf-8bfa59a66293" />
<img width="931" height="162" alt="image" src="https://github.com/user-attachments/assets/672ce121-aef0-42f7-b5fb-274c740ee054" />
<img width="1063" height="336" alt="image" src="https://github.com/user-attachments/assets/6ff2266f-1490-4a07-96c5-7923ee6e0775" />

Step1:
Create Backned Azure SA with enable version for blobs 
Security -->Allow enabling anonymous access on individual containers 
Then Create the Azure SA 
Then Create the container 
Data Storage --> Containers 

Container : backend
saname: credtfstatebackend
rgname: TFStateRG
